Feature: Contact form validation
    As a visitor
    I want to ensure that the contact form on the contact page works correctly

    Scenario: Verify the presence of the input fields to fill my identity inside (firstname, lastname, email, gender, phone, birthdate)
        Given I am on the contact page
        Then I should see the "firstname" input field "text" and fill it
        And I should see the "lastname" input field "text" and fill it
        And I should see the "email" input field "text" and fill it with the correct pattern
        And I should see the "gender" input field "radio" and fill it
        And I should see the "phone" input field "text" and fill it with the correct pattern
        And I should see the "birthdate" input field "text" and click in it to open a calendar to select the correct date

    Scenario: Verify the presence of the input fields to contextualize and fill my demand inside (subject, hobbies, address, state, city, file)
        Given I am on the contact page
        Then I should see the "subject" input field "text", fill it and select a proposition
        And I should see the "hobbies" input field "checkbox" and check at least one option
        And I should see the "address" input field "textarea" and fill it
        And I should see the "state" input field "select" and select an option
        And I should see the "city" input field "select" and select an option
        And I should see the "file" input field "file" if i want to attach a file

    Scenario: Verify the presence of the submit button to send my demand
        Given I am on the contact page and the inputs are filled
        Then I should see the "submit" button and click on it

