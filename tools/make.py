#!/usr/bin/env python3

import zipfile
import os
import re
from config_style_checker import main as check_config_style
from sqf_validator import main as check_sqf_syntax

def remove_dir(path, dir):
    path = path.split(os.path.sep)
    path.remove(dir)
    path = os.path.join(*path)

    return path

def get_version(src):
    script_version_path = os.path.join(src, 'components', 'main', 'script_version.hpp')

    with open(script_version_path, 'r') as file:
      script_version = file.read()
    
    script_major_version = int(re.search(r'\#define MAJOR (\d+)', script_version).group(1))
    script_minor_version = int(re.search(r'\#define MINOR (\d+)', script_version).group(1))
    script_patch_version = int(re.search(r'\#define PATCHLVL (\d+)', script_version).group(1))
    script_build_version = int(re.search(r'\#define BUILD (\d+)', script_version).group(1))

    return [script_major_version, script_minor_version, script_patch_version, script_build_version]

def get_name(src):
    script_mod_path = os.path.join(src, 'components', 'main', 'script_mod.hpp')

    with open(script_mod_path, 'r')as file:
        script_mod = file.read()
    
    script_mod_name = re.search(r'\#define FRAMEWORK (.*)', script_mod).group(1);

    return script_mod_name


def check_scripts(src):
    errorCount = 0
    path = os.path.join(src, 'rsc', 'scripts')

    print("\nChecking Scripts")

    for file in os.listdir(path):
        print("Script detected:   {0}".format(remove_dir(os.path.join(path, file), '..')))
        errorCount += 1
    
    print("------\nErrors detected: {0}".format(errorCount))
    if (errorCount == 0):
        print("Script Check PASSED")
    else:
        print("Script Check FAILED")
    
    return errorCount

def check_loadouts(src):
    errorCount = 0
    path = os.path.join(src, 'rsc', 'loadouts')

    print("\nChecking Loadouts")

    for file in os.listdir(path):
        if file[0] != '!':
            print("Loadout detected:   {0}".format(remove_dir(os.path.join(path, file), '..')))
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
        releaseDir = os.path.join(rootPath, 'release')
        if not os.path.exists(releaseDir):
            os.makedirs(releaseDir)

        versionArr = get_version(src);
        releaseName = os.path.join(releaseDir, '{0}-{1}.{2}.{3}.{4}.zip'.format(get_name(src), versionArr[0], versionArr[1], versionArr[2], versionArr[3])) # @TODO: Get release name from script_mod

        fileCount = 0
        with zipfile.ZipFile(releaseName, 'w', zipfile.ZIP_DEFLATED) as archive:
            for root, dirs, files in os.walk(src):
                for file in files:
                    if file.upper() in ['README.MD', 'TODO.MD', 'CHANGELOG.MD']: continue
                    
                    targetRoot = remove_dir(root, 'framework')
                    print("Zipping: {0}".format(remove_dir(os.path.join(root, file), '..')))
                    archive.write(os.path.join(root, file), os.path.relpath(os.path.join(targetRoot, file), os.path.join(src, '..')))
                    fileCount += 1
        #shutil.make_archive(releaseName, 'zip', src)
    
    print("------\nErrors detected: {0}".format(errorcount))
    if (errorcount == 0):
        print("Release Build PASSED")
        print('{1} ({0} files)'.format(fileCount, remove_dir(releaseName, '..')))
    else:
        print("Release Build FAILED")
    
    return errorcount

def main():
    errorcount = 0
    rootDir = '..'
    for folder in ['framework', 'optionals']:
        src = os.path.join(rootDir, folder)
        if (os.path.exists(src)):
            errorcount += release_build(rootDir, src)

    return errorcount

if __name__=="__main__":
    main()