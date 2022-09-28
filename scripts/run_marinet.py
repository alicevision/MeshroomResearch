import os
import shutil
import glob

RM_FOLDER= False#force remove folders before computation
COMPUTE = "1"#runs computation or not
RESUME = True#will resum computaiton
SUBMIT = True#will submit the job on the grid
FORCE_COMPUTE = False
#run on grid in rez env meshroom-hogm  mrrs aliceVisionVocTree

MESHROOM_ROOT = "/s/apps/users/hogm/meshroom/repo"
MESHROOM_PIPELINE = '/s/apps/users/multiview/mrrs/hogm/mrrs/pipelines/cam_track_marinet.mg'
OUTPUT_FOLDER = "/s/prods/mvg/_source_global/users/hogm/meshroom_marinet_outputs"

scene_folders = glob.glob("/s/prods/marinet/sequence/*/*/common/footage/*")

# "/s/prods/mvg/_source_global/users/hogm/meshroom_marinet_outputs_old/235_050-src-master01-v001-aces-exr/project.mg",
# "/s/prods/mvg/_source_global/users/hogm/meshroom_marinet_outputs_old/235_040-src-master01-v001-aces-exr/project.mg",
# "/s/prods/mvg/_source_global/users/hogm/meshroom_marinet_outputs_old/189_010-src-master01-v001-aces-exr/project.mg"

# scene_folders = ["/s/prods/marinet/sequence/235/235_050/common/footage/235_050-src-master01-v001-aces-exr",
#                  "/s/prods/marinet/sequence/189/189_010/common/footage/189_010-src-master01-v001-aces-exr"
#                 ]

for scene_index, scene_folder in enumerate(scene_folders):

    if "jpg" in scene_folder:
        print("Skipping (jpeg) "+scene_folder)
        continue
    if "distogrid" in scene_folder:
        print("Skipping (distogrid) "+scene_folder)
        continue
    if "confocadre" in scene_folder:
        print("Skipping (confocadre) "+scene_folder)
        continue

    print("Running meshroom for scene %s %d/%d"%(scene_folder, scene_index, len(scene_folders)))

    input_folder = scene_folder
    output_folder = os.path.join(OUTPUT_FOLDER, os.path.basename(scene_folder))

    if os.path.exists(output_folder):
        if RM_FOLDER:
            shutil.rmtree(output_folder)
        else:
            print("Folder for "+scene_folder+"already exists")
            if not RESUME:
                print("Skipping")
                continue
            print("Resuming")
    os.makedirs(output_folder, exist_ok=True)

    executable = "python "+MESHROOM_ROOT+"/bin/meshroom_batch"
    def run_meshroom_batch(up_to_node=None):
        arguments = " -i \""+input_folder+"\""+" -p "+MESHROOM_PIPELINE \
                +" -o \""+output_folder+"\" --cache \""+output_folder+"/MeshroomCache\" --save \""+os.path.join(output_folder,"project.mg")+"\""\
                +" --verbose trace"\
                +" --compute "+COMPUTE
        if up_to_node is not None:
            arguments += " --toNode "+up_to_node
        if SUBMIT:
            arguments += " --submit "
        if FORCE_COMPUTE:
            arguments += " --forceCompute"
        command = executable+" "+arguments
        os.system(command)
        # print(command)

    # run_meshroom_batch("DistortionCalibration")
    run_meshroom_batch("ExportAnimatedCamera_1")
    run_meshroom_batch("ExportAnimatedCamera_2")
