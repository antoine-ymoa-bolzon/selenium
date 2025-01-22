import pytest
import pytest_bdd
from pytest_bdd import parsers

from selenium import webdriver
from selenium.webdriver.common.by import By
from pytest_bdd import scenario ,given, then ,when

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

import keyboard
import time



@pytest.fixture
def browser():
    driver = webdriver.Chrome()
    yield driver
    driver.quit()

def url():
    return "https://demoqa.com/"

#1er scénario concombré --> Verify the presence of the input fields to fill my identity inside (firstname, lastname, email, gender, phone, birthdate)
@scenario('features/contact_form.feature', 'Verify the presence of the input fields to fill my identity inside (firstname, lastname, email, gender, phone, birthdate)')   
def test_input_field_presence():
    pass

@given('I am on the contact page')   
def open_contact_page(browser):
    browser.get(url + "automation-practice-form")

@then('I should see the "firstname" input field "text" and fill it')
def verify_input_presence(browser):


@then('I should see the "lastname" input field "text" and fill it')
def verify_input_presence(browser):
        

@then('I should see the "email" input field "text" and fill it with the correct pattern')
def verify_input_presence(browser):
        

@then('And I should see the "gender" input field "radio" and fill it')
def verify_input_presence(browser):
        

@then('And I should see the "phone" input field "text" and fill it with the correct pattern')
def verify_input_presence(browser):
        

@then('And I should see the "birthdate" input field "text" and click in it to open a calendar to select the correct date')
def verify_input_presence(browser):



    

#2e scénario concombré --> Verify the presence of the input fields to contextualize and fill my demand inside (subject, hobbies, address, state, city, file)
@scenario('features/contact_form.feature', 'Verify the presence of the input fields to contextualize and fill my demand inside (subject, hobbies, address, state, city, file)')

@given('I am on the contact page')   
def open_contact_page(browser):
    browser.get(url + "automation-practice-form")


#3e scénario concombré --> Verify the presence of the input fields to submit my form   
@scenario('features/contact_form.feature', 'Verify the presence of the input fields to submit my form')

@given('I am on the contact page')   
def open_contact_page(browser):
    browser.get(url + "automation-practice-form")


#COMMANDE POUR LANCER LE TEST (APRES OUVERTURE D'UN TERMINAL): pytest nomDuTest.py