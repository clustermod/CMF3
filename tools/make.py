#!/usr/bin/env python3

import zipfile
import os
import re
from config_style_checker import main as check_config_style
from sqf_validator import main as check_sqf_syntax

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

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

    print(bcolors.WARNING + "\nChecking Scripts" + bcolors.ENDC)
    if os.path.exists(path):
        for file in os.listdir(path):
            if file.upper() in ["SCRIPT_COMPONENT.HPP"]: continue
            
            print(bcolors.FAIL + "ERROR" + bcolors.ENDC + " Script detected:   {0}".format(remove_dir(os.path.join(path, file), '..')))
            errorCount += 1
    else:
        print(bcolors.OKCYAN + "DIR" + bcolors.ENDC + " Not found:   {0}".format(remove_dir(path, '..')))
    
    print("------\nErrors detected: {0}".format(errorCount))
    if (errorCount == 0):
        print(bcolors.OKGREEN + "Script Check PASSED" + bcolors.ENDC)
    else:
        print(bcolors.FAIL + "Script Check FAILED" + bcolors.ENDC)
    
    return errorCount

def check_loadouts(src):
    errorCount = 0
    path = os.path.join(src, 'rsc', 'loadouts')

    print(bcolors.WARNING + "\nChecking Loadouts" + bcolors.ENDC)

    if os.path.exists(path):
        for file in os.listdir(path):
            if file[0] != '!':
                print(bcolors.FAIL + "ERROR" + bcolors.ENDC + " Loadout detected:   {0}".format(remove_dir(os.path.join(path, file), '..')))
                errorCount += 1
    else:
        print(bcolors.OKCYAN + "DIR" + bcolors.ENDC + " Not found:   {0}".format(remove_dir(path, '..')))

    print("------\nErrors detected: {0}".format(errorCount))
    if (errorCount == 0):
        print(bcolors.OKGREEN + "Loadout Check PASSED" + bcolors.ENDC)
    else:
        print(bcolors.FAIL + "Loadout Check FAILED" + bcolors.ENDC)
    
    return errorCount

def release_build(rootPath, src, name, versionArr):
    errorcount = 0

    errorcount += check_config_style()
    print("\n")
    errorcount += check_sqf_syntax()
    errorcount += check_scripts(src)
    errorcount += check_loadouts(src)

    print(bcolors.WARNING + "\nBuilding Release ({0})".format(os.path.basename(src)) + bcolors.ENDC)

    if (errorcount == 0):
        releaseDir = os.path.join(rootPath, 'release')
        if not os.path.exists(releaseDir):
            os.makedirs(releaseDir)

        releaseName = os.path.join(releaseDir, '{0}-{1}.{2}.{3}.{4}.zip'.format(name, versionArr[0], versionArr[1], versionArr[2], versionArr[3]))

        # If optionals append directory name
        if os.path.basename(src) != 'framework':
            releaseName = releaseName.replace('.zip', '-{0}.zip'.format(os.path.basename(src)))
        
        fileCount = 0
        with zipfile.ZipFile(releaseName, 'w', zipfile.ZIP_DEFLATED) as archive:
            for root, dirs, files in os.walk(src):
                for file in files:
                    if file.upper() in ['TODO.MD', 'CHANGELOG.MD']: continue
                    if os.path.basename(src) == 'framework' and file.upper() == 'README.MD': continue
                    
                    targetRoot = remove_dir(root, os.path.basename(src))
                    print(bcolors.OKCYAN + "ZIP" + bcolors.ENDC + " Adding File: {0}".format(remove_dir(os.path.join(root, file), '..')))
                    archive.write(os.path.join(root, file), os.path.relpath(os.path.join(targetRoot, file), os.path.join(src, '..')))
                    fileCount += 1
    
    print("------\nErrors detected: {0}".format(errorcount))
    if (errorcount == 0):
        print(bcolors.OKGREEN + "Release Build PASSED" + bcolors.ENDC)
        print('{1} ({0} files)'.format(fileCount, remove_dir(releaseName, '..')))
    else:
        print(bcolors.FAIL + "Release Build FAILED" + bcolors.ENDC)
    
    return errorcount

def main():
    errorcount = 0
    rootDir = '..'
    frameworkVersion = get_version(os.path.join(rootDir, 'framework'));
    frameworkName = get_name(os.path.join(rootDir, 'framework'));
    for folder in ['framework', 'optionals']:
        src = os.path.join(rootDir, folder)
        if (os.path.exists(src)):
            errorcount += release_build(rootDir, src, frameworkName, frameworkVersion)

    return errorcount

if __name__=="__main__":
    main()