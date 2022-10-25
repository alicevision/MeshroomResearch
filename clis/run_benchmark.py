"""
Runs benchmark.
"""
import os
import shutil
import glob

import click

#Sanity check
MESHROOM_ROOT = os.getenv("MESHROOM_INSTALL_DIR")
if MESHROOM_ROOT is None:
    raise BaseException("MESHROOM_INSTALL_DIR not set")
#Auto detect and set paths
this_file_path = os.path.abspath(__file__)
DEFAULT_MESHROOM_PIPELINE = os.path.abspath(os.path.join(this_file_path, "../../pipelines/benchmark/benchmark.mg"))
MESHROOM_NODES_PATH = os.path.abspath(os.path.join(this_file_path, "../../mrrs/nodes/"))

@click.command()
@click.argument('dataset_path')
@click.option('--pipeline', '-p', default=DEFAULT_MESHROOM_PIPELINE, help='Path to the benchmark pipeline.')
@click.option('--output_folder','-o', default="./", help='Output folder to generate results into.')
@click.option('--remove_folders', '-r', is_flag=True, help='Force clean the content of outputs folder.')
@click.option('--dataset_type', '-t',  type=click.Choice(['blendedMVS'], case_sensitive=False), default= "blendedMVS")
@click.option('--compute', '-c', is_flag=True, help='Runs the computation. Will just create project otherwise.')
@click.option('--resume', '-r', is_flag=True, help='Resumes computation if a folder exists, will skip folder otherwise.')
@click.option('--submit', '-s', is_flag=True, help='Will submit the computation on the grid.')
@click.option('--up_to_node', '-u', default=None, help='If computation is enabled, will compute up to the passed node.')

@click.option('--environnement', '-e', default=None, help='Runs in the specified environnement')

def run_benchmark(dataset_path, pipeline, output_folder,
                  remove_folders, dataset_type,
                  compute, resume, submit, up_to_node,
                  environnement):
    print("Welcome to benchmark")
    print("Meshroom path: "+MESHROOM_ROOT)
    scene_folders = os.listdir(dataset_path)
    for scene_index, scene_folder in enumerate(scene_folders):
        print("Running meshroom for scene %s %d/%d"%(scene_folder, scene_index, len(scene_folders)))
        #data preparation for specific datasets
        if dataset_type=="blendedMVS" is not None:
            input_folder = os.path.join(dataset_path, scene_folder, "blended_images")
            invalid_images = list(set(glob.glob(os.path.join(input_folder, "*")))-set(glob.glob(os.path.join(input_folder, "????????.jpg"))))
            image_folder = os.path.join(input_folder, scene_folder, "other")
            os.makedirs(image_folder, exist_ok=True)
            for invalid_image in invalid_images:
                if os.path.isfile(invalid_image):
                    shutil.move(invalid_image, image_folder)
        else:
            raise RuntimeError("Unknown dataset type")
        #folder handling
        scene_output_folder = os.path.join(output_folder, scene_folder)
        if os.path.exists(scene_output_folder):
            if remove_folders:
                shutil.rmtree(scene_output_folder)
            else:
                print("Folder for "+scene_folder+"already exists:")
                if not resume:
                    print("Skipping")
                    continue
                print("Resuming")
        os.makedirs(scene_output_folder, exist_ok=True)
        #run cli # +" --forceCompute" #TODO?
        executable=""
        if environnement:
            executable+="conda activate "+environnement+" && "
        executable += "python "+MESHROOM_ROOT+"/bin/meshroom_batch"
        arguments = " -i \""+input_folder+"\""+" -p "+pipeline \
                   +" -o \""+scene_output_folder+"\" --cache \""+scene_output_folder+"/MeshroomCache\" --save \""+os.path.join(scene_output_folder,"project.mg")+"\""\
                   +" --verbose trace"
        if compute:
            arguments += " --compute "
        if submit:
            arguments += " --submit "
        if up_to_node is not None:
            arguments += " --toNode "+up_to_node
        command = executable+" "+arguments#TODO: see if we cant direclty call api
        print(command)
        os.system(command)

if __name__ == '__main__':
    run_benchmark()