*** Settings ***
Documentation     Robot Framework Example
Library           Selenium2Library

Suite Setup    Open Browser    https://ithelp.ithome.com.tw/    chrome
Suite Teardown    Close Browser

*** Variables ***
${articleName1} =    鼠年全馬鐵人挑戰 WEEK 01：四十週自動化測試 - 前言
${articleName2} =    鼠年全馬鐵人挑戰 WEEK 13：Robot Framework (上)

*** Test Cases ***
My Test
    [Template]    Search Article Template
    ${articleName1}
    ${articleName2}

*** Keywords ***
Click Article Checkbox
    [Documentation]    Click search type checkbox in search area
    Wait Until Element Is Visible    //label[@for="searchArticle"]
    Click Element    //label[@for="searchArticle"]

Click Search Button
    [Documentation]    Click search button in ithelp home page
    Wait Until Element Is Visible    //div[@id="searchDropdown"]
    Click Element    //div[@id="searchDropdown"]

Click Submit Button
    [Documentation]    Click search submit button in search area
    Wait Until Element Is Visible    //form/button[@type="submit"]
    Click Element    //form/button[@type="submit"]

Input Search Content
    [Documentation]    Input search content in search bar
    [Arguments]    ${article}
    Wait Until Element Is Visible    //input[@name="search"]
    Input Text    //input[@name="search"]    ${article}

Search Article Template
    [Documentation]    Tempalte for search ithelp aritcle need give aritcle variable
    [Arguments]    ${article}
    Click Search Button
    Input Search Content    ${article}
    Click Article Checkbox
    Click Submit Button
    Verify Article Is Existing    ${article}

Verify Article Is Existing
    [Documentation]    Verify search article is existing
    [Arguments]    ${article}
    Wait Until Page Contains Element    //h3[@class="qa-list__title"]/a
    ${getArticle} =    Get Text    //h3[@class="qa-list__title"]/a
    Should Be Equal As Strings    ${getArticle}    ${article}