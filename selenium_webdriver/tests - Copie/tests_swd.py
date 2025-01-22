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

@scenario('features/contact_form_vanille.feature', 'Verify the presence of the input field')   
def test_input_field_presence():
    pass

@given('I am on the contact page')   
def open_contact_page(browser):
    browser.get("https://demoqa.com/automation-practice-form")

@then('I should see the "firstname" input field "text" and fill it')
def verify_input_presence(browser):

    browser.find_element(By.ID, "firstName").send_keys("Johnny")

    browser.find_element(By.ID, "lastName").send_keys("Biscotte")
    browser.find_element(By.ID, "userEmail").send_keys("labiscotte@gmail.com")
    browser.find_element(By.ID, "userNumber").send_keys("065525632554")

    print("Etape 1 OK (Nom, Prénom, Email, Téléphone)")
    time.sleep(2)

    browser.find_element(By.XPATH, "//label[.='Male']").click()
    print("Etape 2 OK (Genre)")
    time.sleep(2)

    browser.execute_script("window.scrollTo(0, 400);")

    time.sleep(2)
    print("Etape 3 OK (Scroll)")

    browser.find_element(By.ID, "dateOfBirthInput").click()

    time.sleep(2)
    print("Etape 4 OK (Clic champs date de naissance)")

    browser.find_element(By.CSS_SELECTOR, ".react-datepicker__month-select").click()
    browser.find_element(By.CSS_SELECTOR, ".react-datepicker__month-select").send_keys("March")
    browser.find_element(By.CSS_SELECTOR, ".react-datepicker__year-select").click()
    browser.find_element(By.CSS_SELECTOR, ".react-datepicker__year-select").send_keys("1984")
    browser.find_element(By.CSS_SELECTOR, ".react-datepicker__day--022:not(.react-datepicker__day--outside-month)").click()

    time.sleep(2)
    print("Etape 5 OK (Selection date)")

    browser.find_element(By.ID, "userNumber").click()

    time.sleep(2)
    print("Etape 6 OK (Clic ailleurs pour enlever focus date)")

    browser.find_element(By.XPATH, "//div[.='Sports']").click()
    browser.find_element(By.ID, "subjectsInput").send_keys("Maths")
    time.sleep(1)
    browser.find_element(By.ID, "subjectsInput").send_keys("\ue007")

    time.sleep(2)
    print("Etape 7 OK (Sujet et Hobbies)")

    browser.find_element(By.XPATH, "//textarea[@id='currentAddress']").send_keys("12, Rue de la paix")
    time.sleep(2)
    browser.find_element(By.ID, "react-select-3-input").send_keys("NCR")
    browser.find_element(By.ID, "react-select-3-input").send_keys("\ue007")
    time.sleep(2)
    browser.find_element(By.ID, "react-select-4-input").send_keys("Delhi")
    browser.find_element(By.ID, "react-select-4-input").send_keys("\ue007")
    time.sleep(1)
    print("Etape 8 OK (Pays et Ville)")
    #browser.find_element(By.XPATH, "//input[@id='uploadPicture']").click()

    browser.find_element(By.ID, "submit").send_keys("\ue007")
    time.sleep(1)
    print("Etape 9 OK (Envoi)")




#def submit_form(browser):
#    browser.find_element(By.ID, "submit").click()


#COMMANDE POUR LANCER LE TEST (APRES OUVERTURE D'UN TERMINAL): pytest nomDuTest.py