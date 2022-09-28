#TODO: make this a CLI tool
import os
import numpy as np
import glob
import json 

RUN_OUTPUT_FOLDER = "/s/prods/mvg/_source_global/users/hogm/meshroom_marinet_outputs/"

sequences = [directory for directory in os.listdir(RUN_OUTPUT_FOLDER) if os.path.isdir(os.path.join(RUN_OUTPUT_FOLDER, directory))]
print("%d sequences"%len(sequences))
scenes_ok_segmentation=[]
scenes_ok_baseline=[]
scenes_fail_segmentation=[]
scenes_fail_baseline=[]
scenes_still_running = []
for sequence in sequences:
    sfm_files = glob.glob(os.path.join(RUN_OUTPUT_FOLDER, sequence, "MeshroomCache/StructureFromMotion/*/status"))
    if len(sfm_files)>2:
        print("Warning, sfm have been computed too many time for scene "+sequence+ ". Skiping")
        continue
    # if ("distogrid" in sequence) or ("confocadre" in sequence):
    #     print("Calib sequence, skipping "+sequence)
    #     continue
    json_statuses = [json.load(open(sfm_file, 'r'))for sfm_file in sfm_files ]
    statuses = [json_status["status"] for json_status in json_statuses ]
    if ("SUBMITTED" in statuses) or ("RUNNING" in statuses):
        print("Sequence "+sequence+" still computing")
        scenes_still_running.append(sequence)
        continue
    for json_status in json_statuses:
        if json_status["status"] == "SUCCESS":
            if json_status["nodeName"] == "StructureFromMotion_2":
                scenes_ok_segmentation.append(sequence)
            elif json_status["nodeName"] == "StructureFromMotion_1":
                scenes_ok_baseline.append(sequence)
            else:
                raise RuntimeError("BIIIP")
        elif json_status["status"] == "ERROR":
            if json_status["nodeName"] == "StructureFromMotion_2":
                #FIXME: check segmentation when tru?
                scenes_fail_segmentation.append(sequence)
            elif json_status["nodeName"] == "StructureFromMotion_1":
                scenes_fail_baseline.append(sequence)
            else:
                raise RuntimeError("BIIIP")
        else:
            raise RuntimeError("Unknown status:"+json_status["status"])
# print("%d/%d sequences ok with baseline vs %d with segmentantion"%(len(scenes_ok_baseline), len(sequences), len(scenes_ok_segmentation)))
both_success = set(scenes_ok_segmentation).intersection(set(scenes_ok_baseline))
both_fail = set(scenes_fail_segmentation).intersection(set(scenes_fail_baseline))
success_seg_fail_baseline = set(scenes_ok_segmentation).intersection(set(scenes_fail_baseline))
success_baseline_fail_seg = set(scenes_ok_baseline).intersection(set(scenes_fail_segmentation))

print("%d/%d sequences where still running"%(len(scenes_still_running), len(sequences)))

print("Success baseline n seg (working without seg)")
print(len(both_success))
print("Success seg - baseline (seg help)")
print(len(success_seg_fail_baseline))
print("Fail baseline n seg (seg did not help)")
print(len(both_fail))
print("Success baseline n failed seg (seg worthen)")
print(len(success_baseline_fail_seg))
#%%
with open(os.path.join(RUN_OUTPUT_FOLDER, "marniet_sfm.csv"), "w") as csv_file:
    # csv_file.write("Success baseline n seg (working without seg),Success seg - baseline (seg help),Fail baseline n seg (seg did not help),Success baseline n failed seg (seg worthen)")
    csv_file.write("Success baseline n seg (working without seg)\n")
    [csv_file.write(os.path.join(RUN_OUTPUT_FOLDER,bs)+"\n") for bs in both_success]
    csv_file.write("Success seg - baseline (seg help)\n")
    [csv_file.write(os.path.join(RUN_OUTPUT_FOLDER,ssfb)+"\n") for ssfb in success_seg_fail_baseline]
    csv_file.write("Fail baseline n seg (seg did not help)\n")
    [csv_file.write(os.path.join(RUN_OUTPUT_FOLDER,bf)+"\n") for bf in both_fail]
    csv_file.write("Success baseline n failed seg (seg worthen)\n")
    [csv_file.write(os.path.join(RUN_OUTPUT_FOLDER,sbfs)+"\n") for sbfs in success_baseline_fail_seg]