#!/usr/bin/env python3
import subprocess
import sys


def set_shortcut(name, command, key_combination):
    # defining keys & strings to be used
    key = "org.gnome.settings-daemon.plugins.media-keys custom-keybindings"
    subkey1 = key.replace(" ", ".")[:-1]+":"
    item_s = "/"+key.replace(" ", "/").replace(".", "/")+"/"
    firstname = "custom"
    # get the current list of custom shortcuts
    get = lambda cmd: subprocess.check_output(["/bin/bash", "-c", cmd]).decode("utf-8")
    array_str = get("gsettings get "+key)
    # in case the array was empty, remove the annotation hints
    command_result = array_str.lstrip("@as")
    current = eval(command_result)
    # make sure the additional keybinding mention is no duplicate
    n = 1
    while True:
        new = item_s+firstname+str(n)+"/"
        if new in current:
            n = n+1
        else:
            break
    # add the new keybinding to the list
    current.append(new)
    # create the shortcut, set the name, command and shortcut key
    cmd0 = 'gsettings set '+key+' "'+str(current)+'"'
    cmd1 = 'gsettings set '+subkey1+new+" name '"+name+"'"
    cmd2 = 'gsettings set '+subkey1+new+" command '"+command+"'"
    cmd3 = 'gsettings set '+subkey1+new+" binding '"+key_combination+"'"

    for cmd in [cmd0, cmd1, cmd2, cmd3]:
        print(subprocess.check_output(["/bin/bash", "-c", cmd]))

for i in range(1,len(sys.argv),3):
    set_shortcut(sys.argv[i],sys.argv[i+1],sys.argv[i+2])
    