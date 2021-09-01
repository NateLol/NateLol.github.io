---
title: "Hugo Staticman Comment System"
date: 2021-08-26T20:39:14+08:00
draft: true
---

After this blog has been left aside for a while, I turn back to find out that I'd like to have a self-hosted commenting system after each entry. I noticed that Hugo itself already provided some quick options to implement that. However, most of them are not self-hosted and oftentimes require log in before submitting the comments. 



The staticman came to my attention, which is easy to deploy and can moderate the comments before showing them on site.





## What are needed?

1. [Staticman](https://staticman.net) the API that can receive, check, store comment data.
2. [Heroku](https://heroku.com) app to host staticman for sufficient API call quota.
3. [Gitub](https://github.com) (pages for website hosting and repo for comments stroage)
4. [reCaptcha](https://www.google.com/recaptcha/about/) (to help prevent the spam comments)



The overall workflow for staticman commenting system is illustrated as following:

{{<mermaid>}}

sequenceDiagram

autonumber

participant website [Github]

participant staticman [Heroku]

participant reCaptcha [Google]

participant comments [Github]

website [Github]->>staticman [Heroku]: POST comment data to API
Note over staticman [Heroku]: Check data intergrity

staticman [Heroku]-->>reCaptcha [Google]: reCaptcha check
Note right of reCaptcha [Google]: optional
reCaptcha [Google]-->>staticman [Heroku]: Return results



staticman [Heroku]->>comments [Github]: Create pull request for comment


Note over comments [Github]: Review comments
comments [Github]->>website [Github]: Update website to show 

{{</mermaid>}}





## Steps

Next, I will show the steps to set everything up.

### 1. Deploy Staticman on Heroku 

​	First, create an account on [Heroku](https://heroku.com) before you deploy staticman on it. After you have created the account, go to the Github repo of [staticman](https://github.com/eduardoboucas/staticman) and scroll down to README to find the icon ![img](https://camo.githubusercontent.com/6979881d5a96b7b18a057083bb8aeb87ba35fc279452e29034c1e1c49ade0636/68747470733a2f2f7777772e6865726f6b7563646e2e636f6d2f6465706c6f792f627574746f6e2e737667) and click to jump to Heroku.



### 2. Github repositories

​	Create two separate github repositories to hold website and comments separately. Let's name them as website `website_repo` and comment `comments_repo`.



### 3. Recaptcha

​	Register on Google

Encrypt the reCaptcha with the statiman api deployed on heroku by going to the following url.

```Copurl
https://<app_name>.herokuapp.com/v2/encrypt/<reCaptcha_secret>
```

Copy what's on the page and we denote that as `encrypted_reCaptcha_secret` in the following steps.



### 4. Website Configuration

1. website config:

   Add following configurations in the website config file, `config.toml`

   ```toml
   [params.staticman]
     enable = true
     api = "https://<app_name>.herokuapp.com/v2/entry/<github_user>/<comments_repo>/main/comments"
   
     [params.staticman.reCaptcha]
       enabled = true
       siteKey = "<reCaptcha_siteKey>"
       secret = "<encrypted_Recaptcha_secret>"
   ```

   The most important thing here is that you have to be extremelly careful about the upper case for the `reCaptcha` params, such as, `params.staticman.reCaptcha`, `siteKey`. 







2. staticman files in a theme

   To enable the staticman, there are several dependenices listed as following.









3. 

