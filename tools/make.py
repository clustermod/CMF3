#!/usr/bin/env python3

import shutil
import os
import re
from config_style_checker import main as check_config_style
from sqf_validator import main as check_sqf_syntax

# @TODO: delete README.md from components

def get_version(src):
    script_version_path = "{0}\\components\\main\\script_version.hpp".format(src);

    with open(script_version_path, 'r') as file :
      script_version = file.read()
    
    script_major_version = int(re.search(r'\#define MAJOR (\d+)', script_version).group(1))
    script_minor_version = int(re.search(r'\#define MINOR (\d+)', script_version).group(1))
    script_patch_version = int(re.search(r'\#define PATCHLVL (\d+)', script_version).group(1))
    script_build_version = int(re.search(r'\#define BUILD (\d+)', script_version).group(1))

    return [script_major_version, script_minor_version, script_patch_version, script_build_version]

def check_scripts(src):
    errorCount = 0
    path = src + '\\rsc\\scripts'

    print("\nChecking Scripts")

    for file in os.listdir(path):
        print("Script detected:   {0}\\{1}".format(path, file))
        errorCount += 1
    
    print("------\nErrors detected: {0}".format(errorCount))
    if (errorCount == 0):
        print("Script Check PASSED")
    else:
        print("Script Check FAILED")
    
    return errorCount

def check_loadouts(src):
    errorCount = 0
    path = src + '\\rsc\\loadouts'

    print("\nChecking Loadouts")

    for file in os.listdir(path):
        if file[0] != '!':
            print("Loadout detected:   {0}\\{1}".format(path, file))
            errorCount += 1

    print("------\nErrors detected: {0}".format(errorCount))
    if (errorCount == 0):
        print("Loadout Check PASSED")
    else:
        print("Loadout Check FAILED")
    
    return errorCount

def release_build(rootPath, src):
    errorcount = 0

    errorcount += check_config_style()
    errorcount += check_sqf_syntax()
    errorcount += check_scripts(src)
    errorcount += check_loadouts(src)

    print("\nBuilding Release")

    if (errorcount == 0):
        releaseDir = rootPath + 'release'
        if not os.path.exists(releaseDir):
            os.makedirs(releaseDir)

        versionArr = get_version(src);

        releaseName = '{0}/CMF-{1}.{2}.{3}.{4}'.format(releaseDir, versionArr[0], versionArr[1], versionArr[2], versionArr[3]) # @TODO: Get release name from script_mod
        shutil.make_archive(releaseName, 'zip', src)
    
    print("------\nErrors detected: {0}".format(errorcount))
    if (errorcount == 0):
        print("Release Build PASSED")
    else:
        print("Release Build FAILED")
    
    return errorcount

def main():
    errorcount = 0
    rootDir = '../'
    for folder in ['framework', 'optionals']:
        src = rootDir + '/' + folder
        if (os.path.exists(src)):
            errorcount += release_build(rootDir, src)

    return errorcount

if __name__=="__main__":
    main()