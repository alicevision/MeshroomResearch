#TODO: make this a CLI tool
"""
Scripts that runs meshroom on blendedMVG data.
Will create an run each project.
"""
import os
import shutil
import glob

# https://meshroom-manual.readthedocs.io/en/latest/feature-documentation/cmd/photogrammetry.html

RM_FOLDER= False#force remove folders before computation
MOVE_IMAGES = "????????.jpg"#wildcart to move all files not respecting it in ot a folder, or None to do nothing
COMPUTE = "1"#runs computation or not
RESUME = True#will resum computaiton

if os.name == 'nt':
    #run on local machine
    BLENDED_MVG_ROOT = "C:\\data\\blended_MVS_test"
    MESHROOM_ROOT = "C:\\Dev\\meshroom-develop"
    MESHROOM_PIPELINE = "c:\\Dev\\MeshroomResearch\\pipelines\\benchmark\\benchmark.mg"
    OUTPUT_FOLDER = "C:\\runs"
    LIB_PATH = "C:\\Dev\\AliceVision\\install\\bin;C:\\Dev\\vcpkg\\installed\\x64-windows\\bin"
    MESHROOM_NODES_PATH = "C:/Dev/MeshroomResearch/mrrs/nodes"
    SUBMIT = False#will submit the job on the grid
else:
    #run on grid in rez env meshroom-hogm  mrrs aliceVisionVocTree
    BLENDED_MVG_ROOT = "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/low_res/BlendedMVS"
    MESHROOM_ROOT = "/s/apps/users/hogm/meshroom/repo"
    MESHROOM_PIPELINE = "/s/apps/users/multiview/MeshroomResearch/hogm/mrrs/pipelines/benchmark/benchmark.mg"#mrrs path
    OUTPUT_FOLDER = "/s/prods/mvg/_source_global/users/hogm/meshroom_benchmark_outputs"#"/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/low_res/meshroom_out"
    SUBMIT = True#will submit the job on the grid
scene_folders = os.listdir(BLENDED_MVG_ROOT)

for scene_index, scene_folder in enumerate(scene_folders):
    print("Running meshroom for scene %s %d/%d"%(scene_folder, scene_index, len(scene_folders)))

    input_folder = os.path.join(BLENDED_MVG_ROOT, scene_folder, "blended_images")
    output_folder = os.path.join(OUTPUT_FOLDER, scene_folder)

    if MOVE_IMAGES is not None:#will move all files respecting the format
        invalid_images = list(set(glob.glob(os.path.join(input_folder, "*")))-set(glob.glob(os.path.join(input_folder, MOVE_IMAGES))))
        image_folder = os.path.join(input_folder, scene_folder, "other")
        os.makedirs(image_folder, exist_ok=True)
        for invalid_image in invalid_images:
            if os.path.isfile(invalid_image):
                shutil.move(invalid_image, image_folder)

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
    if os.name == 'nt':
        set_env_vars = "set PYTHONPATH="+MESHROOM_ROOT+" && set PATH="+LIB_PATH+";%PATH% && set MESHROOM_NODES_PATH="+MESHROOM_NODES_PATH
    else:
        set_env_vars = "echo hello"
    executable = "python "+MESHROOM_ROOT+"/bin/meshroom_batch"
    def run_meshroom_batch(up_to_node=None):
        arguments = " -i \""+input_folder+"\""+" -p "+MESHROOM_PIPELINE \
                +" -o \""+output_folder+"\" --cache \""+output_folder+"/MeshroomCache\" --save \""+os.path.join(output_folder,"project.mg")+"\""\
                +" --verbose trace"\
                +" --compute "+COMPUTE\
                # +" --forceCompute"
        if up_to_node is not None:
            arguments += " --toNode "+up_to_node
            #+" --paramOverrides BlendedMVGDataset:sceneId="+str(scene_index)

        if SUBMIT:
            arguments += " --submit "
        command = set_env_vars+"&&"+executable+" "+arguments#FIXME: see if we cant direclty call api
        os.system(command)
        print(command)
    #TODO: run openmvg
    #step 1: open data & GT
    # run_meshroom_batch("BlendedMVGDataset")
    # run_meshroom_batch("Texturing_2") #from GT poses and GT depth maps
    #step 2 normal
    # run_meshroom_batch("Texturing_4") #normal route
    #step 3
    # run_meshroom_batch("Texturing_6") #from GT poses and estimated depth maps

    #run all (usefull to run remaining)
    # run_meshroom_batch()
    #rerun calibration
    # run_meshroom_batch("CalibrationComparison")
    # run_meshroom_batch("DepthMapComparison")
    run_meshroom_batch("Publish")
