# SCM_Nominate-R

![Hero Nominate ICON](ASSETS/SCM_Icons_Nominate.png)

---
SCM_Nominate is a 64bit application written in pascal on a cross platform compiler. It's part of an eco system of applications that make up the SwimClubMeet project. SCM lets amateur swimming clubs manage members and run their club night's.

![The eco system of SCM](ASSETS/SCM_GroupOfIcons.png)

To learn more about SwimClubMeet view the [github pages](https://artanemus.github.io/index.html).

This application runs best on a tablet (Windows). Nominate will significantly reduce the curse of every swim club - the nomination bottle neck.

>You can speed-up nomination by adding more tablets. The core application also can perform the task of getting members nominated. There are advantages to doing this, as it lets you talk with the swimmers and encourage them to swim more events. 😉

If you are interested in following a developer's blog and track my progress then you can find me at [ko-fi](https://ko-fi.com/artanemus).

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/V7V7EU686)

---

### USING Nominate

After install, by default, an icon is placed on the desktop. If you elected to disable this, type **nominate** in the windows search bar to discover it. Else navigate to the **Artanemus** folder on the start bar. (All SCM applications and utilities are located in this folder.)

### ON START-UP

The application will ask you to login to the database. If you are running on a touch-pad, bring the application to full screen - you'll notice it will zoomed (scaled up) making it easier to navigate and enter data.

Select the session then click the **activate button**. (Bottom left of the form.)

Your members must have been assigned a membership number. A four digit code would suffice. Be on the standby with the SCM_Member app to find it for them. Else print membership cards with the SCM_ExtraReports app.  

If you don't wish to type in numbers, then I suggest that you write a quick query to assign their membership number based on their unique MemberID.

        USE [SwimClubMeet]
        GO

        UPDATE [dbo].[Member]
        SET [MembershipNum] = MemberID + 1000
        GO

Members must not be archived. They must be active and tagged as a swimmer. Members can't nominate to events that have been raced.

> Use Windows **Apps and Features** to remove the application.

---

![image](https://github.com/Artanemus/SCM_Nominate-R/assets/69775305/2cc1764a-c897-4200-b205-921969258cc6)

![image](https://github.com/Artanemus/SCM_Nominate-R/assets/69775305/81a3241e-b3d8-4f9b-a039-247dd18e1775)

![image](https://github.com/Artanemus/SCM_Nominate-R/assets/69775305/5e0434ae-a3a9-4f5f-8636-dc9cff70eb0c)


