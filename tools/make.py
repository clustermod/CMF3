#!/usr/bin/env python3

import shutil
import os
import re
from config_style_checker import main as check_config_style
from sqf_validator import main as check_sqf_syntax

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
    path = src + '\\rsc\\scripts'
    if len(os.listdir(path)) != 0:
        print("scripts directory not clean")
        return 1
    
    return 0

def check_loadouts(src):
    path = src + '\\rsc\\loadouts'
    for file in os.listdir(path):
        if file[0] != '!':
            print("Loadouts directory not clean")
            return 1
    
    return 0

def release_build(rootPath, src):
    configTest = check_config_style()
    sqfTest = check_sqf_syntax()
    scripts = check_scripts(src)

    if (configTest == 0 and sqfTest == 0 and scripts == 0):
        releaseDir = rootPath + 'release'
        if not os.path.exists(releaseDir):
            os.makedirs(releaseDir)

        versionArr = get_version(src);

        releaseName = '{0}/CMF-{1}.{2}.{3}.{4}'.format(releaseDir, versionArr[0], versionArr[1], versionArr[2], versionArr[3]) # @TODO: Get release name from script_mod
        shutil.make_archive(releaseName, 'zip', src)

        return True
    
    return False

def main():
    rootDir = '../'
    for folder in ['framework', 'optionals']:
        src = rootDir + '/' + folder
        if (os.path.exists(src)):
            status = release_build(rootDir, src)

    if (status):
        print("Build PASSED")
    else:
        print("Build FAILED")
        return 1

if __name__=="__main__":
    main()