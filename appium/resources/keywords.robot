*** Settings ***

Documentation     This suite contains variable definitions.
Library          OperatingSystem
Library          Process
Library          String
Library          AppiumLibrary
Library          subprocess

Resource         variables.robot

*** Variables ***
&{APP_X}    REMOTE=http://127.0.0.1:4723/wd/hub    
...         VERSION=15    
...         NAME=Android    
...         DEVICE=emulator-5554    
...         CALC_PCK=com.google.android.calculator    
...         CALC_ACT=com.android.calculator2.Calculator    
...         CALC_PATH=C:\Users\Administrateur\AppData\Local\Android\Sdk\platform-tools\com.google.android.calculator_8.4.apk    
...         AUTO_NAME=UiAutomator2
${REMOTE_URL}                     http://127.0.0.1:4723/wd/hub
${PLATFORM_VERSION}               15
${PLATFORM_NAME}                  Android
${DEVICE_NAME}                    emulator-5554
${CALCULATOR_APP_PACKAGE}         com.google.android.calculator
${AUTOMATION_NAME}                UiAutomator2
${CALCULATOR_APP_ACTIVITY}        com.android.calculator2.Calculator
${CALCULATOR_APP_PATH}            C:\Users\Administrateur\AppData\Local\Android\Sdk\platform-tools\com.google.android.calculator_8.4.apk

${EL_PASO}          C:\\Users\\Administrateur\\AppData\\Local\\Android\\Sdk\\platform-tools\\adb.exe
${EMULATOR_NAME}    Pixel_7_API_35
${ADB_COMMAND}      ${EL_PASO}adb devices
${START_COMMAND}    emulator -avd ${EMULATOR_NAME}
${EMULATOR_PATH}   emulator
${ADB_PATH}    C:/Users/Administrateur/AppData/Local/Android/Sdk/platform-tools/
#${EMULATOR_PATH}    C:/Users/Administrateur/AppData/Local/Android/Sdk/emulator/emulator.exe
#${EMULATOR_NAME}    Pixel_4_API_30


*** Keywords ***
Launch an App
    Check ADB Accessibility And Start Emulator If Needed
    Open Application    
        ...    ${REMOTE_URL}    
        ...    platformName=${PLATFORM_NAME}    
        ...    platformVersion=${PLATFORM_VERSION}    
        ...    deviceName=${DEVICE_NAME}    
        ...    appPackage=${CALCULATOR_APP_PACKAGE}    
        ...    appActivity=${CALCULATOR_APP_ACTIVITY}
        ...    automationName=${AUTOMATION_NAME}

A thing was doing
    #truc
    Click Element    com.google.android.calculator:id/digit_7

I do a thing
    #truc fait
    Element Should Be Visible    com.google.android.calculator:id/formula



#Méthodes pour lancer l'émulateur avant déroulement du test, si émulator pas lancé au préalable
#Check ADB Accessibility And Start Emulator If Needed
#    Check ADB Accessibility And Start Emulator If Needed
#    Log To Console    Chemin utilisé : ${ADB_PATH}
#    
#    # Vérifie la version d'ADB
#    ${adb_version_result}    Run Process    ${ADB_PATH} version    stdout=PIPE    stderr=PIPE    shell=True
#    Log To Console    ADB Version Output: ${adb_version_result.stdout}
#    Should Be Equal As Strings    ${adb_version_result.rc}    0    ADB introuvable ou non fonctionnel. Assurez-vous que le chemin est correct.
#
#    # Liste les appareils connectés
#    ${adb_devices_result}    Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
#    ${adb_devices_output}    Set Variable    ${adb_devices_result.stdout}
#    Log To Console    ADB Devices Output: ${adb_devices_output}
#
#    # Nettoie la sortie pour simplifier la comparaison
#    ${adb_devices_clean}    Evaluate    str("""${adb_devices_output}""").replace('\\n', ' ').replace('\\t', ' ')
#    Log To Console    Cleaned ADB Devices Output: ${adb_devices_clean}
#
#    # Vérifie si un émulateur est déjà actif
#    Run Keyword If    "'emulator-' not in ${adb_devices_clean}"    Start Emulator


XCheck ADB Accessibility And Start Emulator If Needed
    Log To Console    Chemin utilisé : ${ADB_PATH}
    
    # Vérifie la version d'ADB
    ${adb_version_result}    Run Process    ${ADB_PATH} version    stdout=PIPE    stderr=PIPE    shell=True
    Log To Console    ADB Version Output: ${adb_version_result.stdout}
    Should Be Equal As Strings    ${adb_version_result.rc}    0    ADB introuvable ou non fonctionnel. Assurez-vous que le chemin est correct.

    # Vérifie la liste des devices avec une limite d'attente
    XWait For Emulator To Be Ready



XWait For Emulator To Be Ready
    [Arguments]    ${max_retries}=5    ${interval}=5
    FOR    ${i}    IN RANGE    1    ${max_retries}+1
        Log To Console    Vérification des devices connectés, tentative ${i}/${max_retries}...
        ${adb_devices_result}    Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
        ${adb_devices_output}    Set Variable    ${adb_devices_result.stdout}
        Log To Console    ADB Devices Output: ${adb_devices_output}

        ${adb_devices_clean}    Evaluate    str("""${adb_devices_output}""").replace('\\n', ' ').replace('\\t', ' ')
        Log To Console    Cleaned ADB Devices Output: ${adb_devices_clean}

        # Si un émulateur est trouvé, sortir de la boucle
        Run Keyword If    "'emulator-' in ${adb_devices_clean}"    Exit For Loop

        # Si aucun émulateur n'est trouvé et qu'on atteint la dernière tentative, lever une erreur
        Run Keyword If    "${i} == ${max_retries}"    Fail    Aucun émulateur trouvé après ${max_retries} tentatives.

        # Sinon, démarrer l'émulateur et attendre
        Log To Console    Aucune instance détectée. Démarrage de l'émulateur...
        Start Emulator
        Sleep    ${interval}
    END




XStart Emulator
    [Documentation]    Lance l'émulateur spécifié.
    ${result}    Run Process    ${EMULATOR_PATH} -avd ${EMULATOR_NAME}    stdout=PIPE    stderr=PIPE    shell=True
    Log To Console    Emulator Output: ${result}
    Log To Console    Emulator Error: ${result}
    XWait Until Emulator Is Ready

XWait Until Emulator Is Ready
    [Documentation]    Attend que l’émulateur soit prêt.
    FOR    ${index}    IN RANGE    1    30
        ${result}    Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
        Run Keyword If    'emulator-' in ${result}    Exit For Loop
        Sleep    1s
    END
    Run Keyword If    'emulator-' not in ${result}    Fail    L'émulateur n'a pas pu démarrer dans le délai imparti.



Check ADB Accessibility And Start Emulator If Needed
    #Start Emulator
    #Start Emulator If Not Running
    Test ADB Command





YCheck ADB Accessibility
    Log To Console    Chemin utilisé : ${ADB_PATH}
    ${adb_version} =    Process.Run Process    ${ADB_PATH} version    stdout=PIPE    stderr=PIPE    shell=True
    Log To Console    ADB Version Output: ${adb_version.stdout}
    Log To Console    ADB Error Output: ${adb_version.stderr}
    Should Be Equal As Strings    ${adb_version.rc}    0    ADB introuvable ou non fonctionnel. Assurez-vous que le chemin est correct.

YStart Emulator If Not Running
    Restart ADB
    Log To Console    Vérification des devices connectés...
    FOR    ${i}    IN RANGE    1    5
        ${adb_devices} =    Process.Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
        #${adb_devices_clean} =    Evaluate    str(${adb_devices.stdout}).replace('\\n', ' ').replace('\\t', ' ')
        #${adb_devices_clean} =    BuiltIn.Evaluate    str('${adb_devices.stdout}').replace('\\n', ' ').replace('\\t', ' ')
        Log To Console    ADB Raw Output: ${adb_devices.stdout}
        ${adb_devices_clean} =    BuiltIn.Evaluate    str(${adb_devices.stdout}).replace('\\n', ' ').replace('\\t', ' ')


        Run Keyword If    'emulator-' in ${adb_devices_clean}    Exit For Loop
        Log To Console    Aucune émulateur détecté. Tentative ${i}/5...
        Sleep    5s
    END
    Run Keyword If    'emulator-' not in ${adb_devices_clean}    Start Emulator
    Should Contain    ${adb_devices_clean}    emulator-    Aucun émulateur détecté après plusieurs tentatives.

YStart Emulator
    Log To Console    Démarrage de l'émulateur...
    ${result} =  Process.Run Process    ${EMULATOR_PATH} -avd ${DEVICE_NAME}    stdout=PIPE    stderr=PIPE    shell=True
    Sleep    30s
    Log To Console    L'émulateur devrait maintenant être actif.

YRestart ADB
    Process.Run Process    ${ADB_PATH} kill-server    stdout=PIPE    stderr=PIPE    shell=True
    Sleep    2s
    Process.Run Process    ${ADB_PATH} start-server    stdout=PIPE    stderr=PIPE    shell=True
    Sleep    2s




ZStart Emulator If Not Running
    Log To Console    Vérification des devices connectés...
    ${adb_devices} =    Process.Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
    #${adb_devices_clean} =    BuiltIn.Evaluate    str(${adb_devices.stdout}).replace('\\n', ' ').replace('\\t', ' ')
    ${adb_devices_clean} =    BuiltIn.Evaluate    str(${adb_devices.stdout.decode('utf-8')}).replace('\\n', ' ').replace('\\t', ' ')

    Log To Console    Cleaned ADB Devices Output: ${adb_devices_clean}

    # Vérifier si un émulateur est déjà actif
    Run Keyword If    'emulator-' not in ${adb_devices_clean}    Start Emulator



WStart Emulator If Not Running
    Log To Console     Vérification des devices connectés...
    
    ${adb_raw} =    Process.Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
    Log To Console    Raw ADB Output: ${adb_raw.stdout}

    ${adb_cleaned} =    Evaluate    """str('${adb_raw.stdout}').strip().replace('\n', ' ').replace('\t', ' ')"""
    Log To Console       Cleaned ADB Devices Output: ${adb_cleaned}


    #${adb_devices_clean} =    Evaluate    repr(${adb_raw}).strip().replace('\\n', ' ').replace('\\t', ' ')
    #${adb_devices_clean} =  Evaluate  "${adb_raw}".strip().replace('\\n', ' ').replace('\\t', ' ')
    #${adb_devices_clean} =    Evaluate    """str('${adb_raw}').strip().replace('\\n', ' ').replace('\\t', ' ')"""
    #Log     Cleaned ADB Devices Output: ${adb_devices_clean}

    ${condition} =    Evaluate    "'emulator-' not in '${adb_cleaned}'"
    Log To Console    Condition Evaluated: ${condition}

    Run Keyword If    ${condition}    Log    Aucun émulateur détecté. Démarrage de l'émulateur...
    Run Keyword If    ${condition}    Process.Run Process    emulator -avd Pixel_7_API_35


    #Run Keyword If     'emulator-' not in   ${adb_devices_clean}    Start Emulator
    ${adb_final} =    Process.Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
    ${final_cleaned} =    Evaluate    """str('${adb_final.stdout}').strip().replace('\\n', ' ').replace('\\t', ' ')"""
    Log    Final Devices List: ${final_cleaned}


Start Emulator
    Log To Console    Aucun émulateur détecté. Démarrage de l'émulateur...
    Process.Run Process    ${EMULATOR_PATH} -avd ${EMULATOR_NAME} -netdelay none -netspeed full    shell=True

    # Attendre un moment pour que l'émulateur démarre
    Log To Console    Attente de l'initialisation de l'émulateur...
    Sleep    20s

    # Redémarrer ADB pour détecter le nouvel émulateur
    Restart ADB
    Wait For Emulator To Connect


Restart ADB
    Log To Console    Restarting ADB...
    Process.Run Process    ${ADB_PATH} kill-server    stdout=PIPE    stderr=PIPE    shell=True
    Sleep    2s
    Process.Run Process    ${ADB_PATH} start-server    stdout=PIPE    stderr=PIPE    shell=True
    Sleep    2s

Wait For Emulator To Connect
    Log To Console    Vérification des devices connectés...
    FOR    ${i}    IN RANGE    1    10
        Log To Console    Tentative ${i}...
        ${adb_devices} =    Process.Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
        ${adb_devices_clean} =    BuiltIn.Evaluate    str(${adb_devices.stdout}).replace('\\n', ' ').replace('\\t', ' ')
        Log To Console    Cleaned ADB Devices Output: ${adb_devices_clean}

        # Si l'émulateur est détecté, quitter la boucle
        Run Keyword If    'emulator-' in ${adb_devices_clean}    Exit For Loop
        Sleep    5s
    END

    # Si aucun émulateur n'est détecté après la boucle, échouer
    Run Keyword If    'emulator-' not in ${adb_devices_clean}    Fail    Aucun appareil détecté après le démarrage de l'émulateur !



Start Emulator If Not Running
    ${adb_raw} =    Process.Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
    Log To Console    Raw ADB Output: ${adb_raw.stdout}

    ${adb_cleaned} =    Replace String    ${adb_raw.stdout}    \n    SPACE
    ${adb_cleaned} =    Replace String    ${adb_cleaned}    \t    SPACE
    Log To Console    Cleaned ADB Devices Output: ${adb_cleaned}
    ${adb_raw}    Run Process    adb    devices    stdout=True    stderr=False
    ${adb_cleaned}=    Evaluate    str('${adb_raw.stdout}'.strip().replace('\\n', 'SPACE').replace('\\t', 'SPACE'))
    Log To Console    Raw ADB Output: ${adb_raw.stdout}
    Log To Console    Cleaned ADB Devices Output: ${adb_cleaned}

    # Vérification si un émulateur est déjà lancé
    IF    '${adb_cleaned}' Contains 'emulator-'
        Log To Console    Émulateur détecté
    ELSE
        Log To Console    Aucun émulateur détecté. Démarrage de l'émulateur...
        Run Process     emulator -avd Pixel_7_API_35
        Sleep   10s
    END

    ${adb_final} =    Process.Run Process    ${ADB_PATH} devices    stdout=PIPE    stderr=PIPE    shell=True
    ${final_cleaned} =    Replace String    ${adb_final.stdout}    \n    SPACE
    ${final_cleaned} =    Replace String    ${final_cleaned}    \t    SPACE
    Log To Console    Final Devices List: ${final_cleaned}



Test ADB Command
    ${adb_raw}    Run Process    ${ADB_PATH}adb    devices    stdout=True    stderr=False
    Log To Console    ADB Raw Output: ${adb_raw.stdout}