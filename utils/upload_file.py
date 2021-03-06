# This file upload the image file in \assets\ directory to sm.ms.com
# Then put the json info to a file in assets for later usage.
# This file also contain a\two functions to delete all used image fiies and get all file from sm.ms for later useage.
# Due to the upload rule of sm.ms this script cannot be run all the way if you have more than 100 file to upload.
# If you have more than 100 file to upload, please change the parameter in the range function in main.

#References:
#https://sm.ms/doc/
#https://stackoverflow.com/questions/12309269/how-do-i-write-json-data-to-a-file
#https://www.codementor.io/aviaryan/downloading-files-from-urls-in-python-77q3bs0un
#https://stackoverflow.com/questions/6996603/how-to-delete-a-file-or-folder
#https://stackoverflow.com/questions/2835559/parsing-values-from-a-json-file

import os
import requests
import json
import time
from tqdm import tqdm

def list_files(folder):
    ''' This function read all the file with the file extension ".bmp" in a folder.
    And put their full file name in a list.'''
    file_list = []
    for temp in os.listdir(folder):
        if temp.endswith('.bmp'):
            file_list.append(temp)
    return file_list

def list_files_al(folder):
    ''' This function read all the file with the file extension ".json" in a folder.
    And put their file name without extension in a list.'''
    file_list = []
    for temp in os.listdir(folder):
        if temp.endswith('.json'):
            file_list.append(temp[0 : -5])
    return file_list

def ul_file(file):
    '''Upload file to sm.ms using post http request.
    '''
    # tested
    url = 'https://sm.ms/api/upload'
    f = open(file, 'rb')
    js = requests.post(url, files={'smfile': f}).json()
    while js['code'] != 'success':
        #time.sleep(10)
        js = requests.post(url, files={'smfile': f}).json()
    if js['code'] == 'success':
        with open('assets\\' + js['data']['filename'] + '.json', 'w') as temp:
            json.dump(js, temp)

def wt_file(url, name):
    #tested
    '''Dowload and save a file locally using get http methond.
    '''
    r = requests.get(url, allow_redirects=True)
    with open(name, 'wb') as f:
        f.write(r.content)

def dl_files(folder):
    '''Delete all file with the extension ".bmp" from a folder.
    '''
    for temp in os.listdir(folder):
        if temp.endswith('.bmp'):
            os.remove(temp)

def dw_files(folder):
    '''Download all file in a folder which discribed in a json file.
    '''
    ls = list_files_al(folder)
    for temp in ls:
        data = json.load(open(temp + '.json'))
        url = data['data']['url']
        name = data['data']['filename']
        wt_file(url, name)

if __name__ == '__main__':
    ls = list_files('assets')
    for i in tqdm(range(len(ls))):
        file = ls[i]
        ul_file('assets\\' + file)