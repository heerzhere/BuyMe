# BuyMe

## Project Structure

```
📦BuyMe
 ┣ 📂.idea // Don't Need this for Eclipse
 ┣ 📂sql
 ┃ ┗ 📜buyme.sql
 ┣ 📂src
 ┃ ┣ 📂database
 ┃ ┃ ┣ 📜Database.java
 ┃ ┃ ┗ 📜db.properties
 ┃ ┗ 📂util
 ┃ ┃ ┣ 📜Account.java
 ┃ ┃ ┣ 📜Aircraft.java
 ┃ ┃ ┣ 📜AuctionItem.java
 ┃ ┃ ┣ 📜Boat.java
 ┃ ┃ ┣ 📜Car.java
 ┃ ┃ ┗ 📜QuestionAnswer.java
 ┣ 📂WebContent
 ┃ ┣ 📂css
 ┃ ┃ ┗ 📜main.css
 ┃ ┣ 📂js
 ┃ ┃ ┗ 📜main.js
 ┃ ┣ 📂META-INF
 ┃ ┃ ┗ 📜MANIFEST.MF
 ┃ ┣ 📂WEB-INF
 ┃ ┃ ┣ 📂lib
 ┃ ┃ ┃ ┗ 📜mysql-connector-java-8.0.23.jar // Add your own jar file
 ┃ ┃ ┗ 📜web.xml
 ┃ ┣ 📜accountProcess.jsp
 ┃ ┣ 📜answerProcess.jsp
 ┃ ┣ 📜auction.jsp
 ┃ ┣ 📜auctionAircraft.jsp
 ┃ ┣ 📜auctionBoat.jsp
 ┃ ┣ 📜auctionCar.jsp
 ┃ ┣ 📜auctionDetails.jsp
 ┃ ┣ 📜auctionList.jsp
 ┃ ┣ 📜auctionProcess.jsp
 ┃ ┣ 📜createCustomerRepAccount.jsp
 ┃ ┣ 📜deactivateAccount.jsp
 ┃ ┣ 📜deactivateAccountProcess.jsp
 ┃ ┣ 📜editAccountInformation.jsp
 ┃ ┣ 📜index.jsp
 ┃ ┣ 📜login.jsp
 ┃ ┣ 📜loginProcess.jsp
 ┃ ┣ 📜logout.jsp
 ┃ ┣ 📜navigationBar.jsp
 ┃ ┣ 📜profile.jsp
 ┃ ┣ 📜question.jsp
 ┃ ┣ 📜questionDetails.jsp
 ┃ ┣ 📜questionProcess.jsp
 ┃ ┣ 📜questionsAndAnswers.jsp
 ┃ ┣ 📜register.jsp
 ┃ ┣ 📜salesReport.jsp
 ┃ ┣ 📜salesReportProcess.jsp
 ┃ ┗ 📜userProfile.jsp
 ┣ 📜.classpath
 ┣ 📜.gitignore
 ┣ 📜.project
 ┣ 📜BuyMe.iml // Don't Need this for Eclipse
 ┗ 📜README.md
```

- Add your own db.properties to database package

  - Contents of db.properties

    ```
    username = yourMySQLUsername //e.g. root
    password = yourMySQLPassword //e.g. password
    ```

- Add your own mysql-connector-java jar to WebContent/WEB-INF/lib/

  - Or add jar file as external library (IntelliJ)
