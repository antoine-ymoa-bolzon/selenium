Feature: Contact form validation
    As a visitor
    I want to ensure that the contact form on the contact page works correctly

    Scenario: Verify the presence of the input field
        Given I am on the contact page
        Then I should see the "firstname" input field "text" and fill it
