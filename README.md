# SCM_Nominate-R

![Hero Nominate ICON](ASSETS/SCM_Icons_Nominate.png)

---
SCM_Nominate is a 64bit application written in pascal on a cross platform compiler. It's part of an eco system of applications that make up the SwimClubMeet project. SCM lets amateur swimming clubs manage members and run their club night's.

![The eco system of SCM](ASSETS/SCM_GroupOfIcons.png)

To learn more about SCM view the [github pages](https://artanemus.github.io/index.html).

Currently the only platform available is Windows. Future releases of the SCM_Nominate may include Android and iOS. This application runs best on MS Surface Pro.

Nominate will significantly reduce the curse of every swim club - the nomination bottle neck.

>As a side note: You can also improve throughput by using more laptops running the core application. There are advantages to doing this, as it lets you talk with the swimmers and encourage them to swim more events. 😉

If you are interested in following a developer's blog and track my progress then you can find me at [ko-fi](https://ko-fi.com/artanemus).

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/V7V7EU686)

---

### USING Nominate

After install, by default, an icon is placed on the desktop. If you elected to disable this, type **nomi** in the windows search bar to discover it. Else navigate to the **Artanemus** folder on the start bar. (All SCM applications and utilities are located in this folder.)

### ON START-UP

The application will ask you to login to the database. If you are running on a touch-pad, bring the application to full screen - you'll notice it will zoomed (scaled up) making it easier to navigate and enter data. Currently there is no help file for this application.

Select the session then click the **activate icon**.

Needless to say, your members must have been assigned a membership number. A four digit code would suffice. Be on the standby with the SCM_Member app to find it for them. Else print (and laminate for wet environments 😊) membership cards with the SCM_ExtraReports app.  

If you don't wish to type in numbers, then I suggest that you write a quick query to assign their membership number based on their unique MemberID. Perhaps a future SCM UI option?

        USE [SwimClubMeet]
        GO

        UPDATE [dbo].[Member]
        SET [MembershipNum] = MemberID + 1000
        GO

Members can't nominate to **raced** events.

> Use Windows **Apps and Features** to remove the application.

---
![ScreenShot tabsheet 2.](ASSETS/Screenshot%202022-09-11%20132136.JPG)

![ScreenShot tabsheet 3.](ASSETS/Screenshot%202022-09-11%20132216.JPG)

