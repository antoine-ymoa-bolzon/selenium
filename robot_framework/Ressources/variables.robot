*** Settings ***
Documentation     This suite contains variable definitions.

*** Variables ***
${NUMBER}                   42
${URL}                     https://demoqa.com/
${SITE}                    SauceDemo
${LOGIN_SD}                standard_user
${PWD_SD}                    secret_sauce
${SD_ARTICLE}              backpack
@{SD_ARTICLES}              backpack    bike-light  onesie
${PRODUCT}                 Lego
${PRENOM}                    Johnny
${NOM}                        Biscotte
${CP}                        59150

${TEXTEHUMAIN1}             Bonjour, je suis navré de vous déranger, mais je n'arrive plus à accéder à votre site...
${TEXTEHUMAIN2}            Il paraîtrait que je ne suis pas humain. Pensée troublante dont je ferai part
${TEXTEHUMAIN3}            à mon processeur de cognition lorsqu'il sera de nouveau opérationnel après sa mise à jour.
${TEXTEHUMAIN4}            En attendant, je vous souhaite une agréable fin de journée humaine
@{TEXTECOMPLET}            ${TEXTEHUMAIN1}    ${TEXTEHUMAIN2}    ${TEXTEHUMAIN3}    ${TEXTEHUMAIN4}
@{LIST}                    one    two    three
&{DICTIONARY}              string=${PRODUCT}    number=${NUMBER}    list=@{LIST}
${ENVIRONMENT_VARIABLE}    %{PATH=Default value}


