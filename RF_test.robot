*** Settings ***
Documentation     Robot Framework Example
Library           Selenium2Library

Suite Setup    Open Browser    https://webreg.tpech.gov.tw/RegOnline1_1.aspx?ZCode=F    chrome
Suite Teardown    Close Browser

*** Variables ***
${directionsText} =    1. 確診代領藥防疫門診請親友攜帶確診病人健保卡，掛家庭醫學科、胸腔內科、感染科看診開藥。\n2. 民眾14天內有國外旅遊史，並出現發燒、咳嗽、嘔吐、腹瀉等症狀，請立即配戴外科口罩，至本院急診室就診，\n並主動告知醫護人員旅遊史、職業史、接觸史、群聚史，以便儘速為您診療。\n3. 腫瘤醫學整合門診於南楝二樓門診看診：\n星期二上午-呂志得醫師、陳朝宗醫師；星期三下午-鄭企峰醫師、陳安履醫師；星期五上午-周益聖醫師、周暉哲醫師。
${alertText} =    民眾14天內有國際旅遊史或居住史， 
...  或處於7日自主健康管理期者(已過14天居家檢疫/隔離者)， 
...  若出現發燒、咳嗽、喉嚨痛、流鼻水、 
...  嘔吐、腹瀉、嗅味覺異常或肺炎等症狀， 
...  請先聯絡1922或台北市防疫專線2375-3782， 
...  由專人協助安排適當交通工具， 
...  並佩戴好外科口罩，至本院急診室就診。 
...   
...  請務必主動告知醫護人員旅遊史、職業史、接觸史及有無群聚史， 
...  以利儘速為您診療。
${doctorName} =    陳慧嫻

*** Test Cases ***
Alert Text Test
    [Template]    Verify Alert Text
    ${alertText}

directionsText Text Test
    [Template]    Directions Text Template
    ${directionsText}

Doctor Name Test
    [Template]    Search Doctor Name Template
    ${doctorName}

*** Keywords ***
Click Division Button
    [Documentation]    Choose Division 
    Wait Until Element Is Visible    //*[@id="DL3_ctl11_HyperLink2"]
    Click Element    //*[@id="DL3_ctl11_HyperLink2"]

Click Doctor Information Page
    [Documentation]    Click doctor information page button
    Wait Until Element Is Visible    //*[@id="Table1"]/tbody/tr[1]/td/table/tbody/tr/td/div/div/font[1]/table[1]/tbody/tr[2]/td[2]/div/a[4]
    Click Element    //*[@id="Table1"]/tbody/tr[1]/td/table/tbody/tr/td/div/div/font[1]/table[1]/tbody/tr[2]/td[2]/div/a[4]

Search Doctor Name Template
    [Documentation]    Template for Search doctor name need give name variable
    [Arguments]    ${name}
    Click Division Button
    Click Doctor Information Page
    Verify Doctor Name    ${name}

Verify Doctor Name
    [Documentation]    Verify doctor's name 
    [Arguments]    ${name}
    Wait Until Page Contains Element    //*[@id="DrLab"]
    ${getText} =    Get Text    //*[@id="DrLab"]
    Should Be Equal As Strings    ${getText}    ${name}

Verify Message
    [Documentation]    Find message
    [Arguments]    ${directionsText}
    Wait Until Element Is Visible    //*[@id="Label1"]
    ${getText} =    Get Text    //*[@id="Label1"]
    Should Be Equal As Strings    ${getText}    ${directionsText}

Directions Text Template
    [Documentation]    Front page message
    [Arguments]    ${directionsText}
    Verify Message    ${directionsText}

Verify Alert Text
    [Documentation]    Verify alert text is correct or not
    [Arguments]    ${alertText}
    Alert Should Be Present    ${alertText}


        