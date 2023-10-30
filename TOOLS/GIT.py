"GIT"  # https://www.youtube.com/watch?v=tRZGeaHPoaw&ab_channel=KevinStratvert

"""
ЛОГВА ДРУГ ЧОВЕК
        git config --global user.name "Yasen Sotirov"
        git config --global user.email "ia.sotirov@gmail.com"


ПРОВЕРЯВА СТАТУСА НА STAGING AREA -дали има нещо за commit
        git status


STAGING AREA
    # качва всички промени в staging-а
        git add .   
    # качва конкретен файл
        git add main.py
    # сваля от staging-a
        git restore --staged <file_name>        


COMMIT TO REPO
    # от staging area качва в самия гит
        git commit -m <message>
        
        
        
ПРЕГЛЕД НА НАПРАВЕНИТЕ COMMIT
    # отваря предишен commit или по име 
        git checkout <commit name> 
         
    

        Help git config
    git config -h
    
        ПОДРОБНО ИНФО ЗА ДАДЕНА КОМАНДА
    git help {command}
    
    # Прави ново Репозитори
    git init


    ЛОГВАНЕ
    ПОКАЗВА КОЙ Е ЛОГНАТ
git config --global user.name
git config --global user.email



# Създаване на default branch
git config --global init.default branch main

# Чисти терминала - само за gitbash, не работи в pycharm terminal
clear

# Премахва фаил/папка от репото и не я траква повече
git rm -r --cached "folder_name"





# Траква отново всички файлове
git add --all



# Commit - snapshot на всички файлове към момента
git commit -a -m "Message in quotes"

# Трие файл
git rm "file_name"

# Rename move from old to new file name
git rm "old_file_name" "new_file_name"

# Проверка на всички commit
git log

git fetch - показва новите неща от репото без да ги сваля

# Pull от репото
git pull

git log - показва всики камити до сега
commit 9a6a5a4503ad1f0b1d9727d6d122787c3413fdf4 (HEAD -> main, origin/main)
Author: Philip Sotirov <me@philipsotirov.com>
Date:   Fri Aug 11 18:54:42 2023 +0300

    Add .gitignore

# Компактна версия на горното
git log --oneline


# Добавя към стейджа конкретен фаил
git add file_name

# добавя всички променнени файлове към стейджа
гит адд .


сваля от сеейджа всички файл
git reset


git reset path/fail_name

след като съм ги аднал камитвам фаливете


# Показва адреса на репото на сървъра - има два адреса за fech  и за push
git remote -v


# Показва на къде "гледам" към кой бранч или commit
HEAD -> main


# създава нов branch
git checkout -b branch_name
или
git branch branch_name



отиване на мейн
git checkout main

# присъединяване на бранч към мейна
git merge branch_to_merge_kam_main

№ накрая изпращам към сървъра с push-вам за да кажа на orgin-a





"GIT"  # https://docs.github.com/en/get-started/using-git/about-git
# https://www.youtube.com/watch?v=SWYqp7iY_Tc&ab_channel=TraversyMedia
# оновен курс




# https://learngitbranching.js.org/
# branching



"ИНИЦИАЛИЗИРАНЕ НА ПРАЗНО РЕПО"
# git init


"ПРОВЕРКА СТАТУС working directory & staging area"
# git status


"ДОБАВЯНЕ ФАЙЛ КЪМ staging area"
# git add


"commit a file to our git repository"
# git commit


"ТРИТЕ СЪСТОЯНИЯ НА git"
# Working directory
# Staging area
# Repository


"КОМАДА ЗА ПРОВЕРКА ИСТОРИЯТА НА commits"
# git log


"КОМАНДА ЗА ДОБАВЯНЕ НА ВСИЧКИ ФАЙЛОВЕ И ПАПКИ КЪМ staging area"
# git add -A


"КОМАНДА ЗА ПРЕМАХВАНЕ НА main.py от staging area"
# git reset HEAD main.py

"""

# import os
# from random import randint
#
# for i in range(1, 365):
#     for j in range(0, randint(1, 10)):
#         d = str(i) + ' days ago'
#         with open('file.txt', 'a') as file:
#             file.write(d)
#         os.system('git add .')
#         os.system('git commit --date="' + d + '" -m "commit"')
# os.system('git push -u origin main')

