---
title: "Multiple Git Account on Same Machine"
date: 2021-09-01T11:55:39+08:00
draft: true
tags: [git]
categories: [Misc]
---



It is quite often that we want to set up multiple git accounts on the same computer, e.g., `user_work` for work and `user_private` for private use only. 

**Github has removed the support for password authentication since August 13, 2021, which means we have to switch to use the personal access token, such as ssh key.**

## Generate SSH keys

You can check if you already have any existing SSH key by executing ` ls -al ~/.ssh` in your terminal. All existing public and private key pairs will be listed, in most cases, you get something default like `~/.ssh/id_rsa`. 

My personal preference is to generate account specific key, and save `user@work.com` as tag for the public keys

``` shell
# generate for user_work
$ ssh-keygen -t rsa -C "<user@work.com>" -f "<user_work>"
# generate for user_private
$ ssh-keygen -t rsa -C "<user@private.com>" -f "<user_private>"
```

Thus, you have two different keys generated:

```shell
# keys for user_work
~/.ssh/id_rsa_<user_work>
~/.ssh/id_rsa_<user_work>.pub
# keys for user_private
~/.ssh/id_rsa_<user_private>
~/.ssh/id_rsa_<user_private>.pub
```

## Add SSH key to corresponding Github account

Now that we have the keys created for each account and we want to ask Github to trust them. By doing so, you are able to access repositories in terminal. The process for both `user_work` and `user_private` Github account is identical except for the SSH keys, I will take `user_work` as example.

1.  Log in to `user_work` Github account.
2.  Go to `Settings` by clicking your profile on the top right corner of the page.
3. Select `SSH and GPG keys` in the menu to the left.
4. Click on `New SSH key` 
5. Copy what's in `~/.ssh/id_rsa_<user_work>.pub` and paste on the site.

It is done!



## Configure SSH

For ease of use, we need to create SSH keys for different accounts. The SSH config file is located at `~/.ssh/config`. 

```shell
cd ~/.ssh
vim config
```

  

Then key in the following 



This is mainly to keep a record of how to configure multiple git accounts on the same machine.



## Switching SSH key in ssh-agent

When you have multiple SSH keys in the system for multiple accounts, you might run into following problem when you are working at the same time on both `user_work` and `user_private` repos.

```shell
$ git push
remote: Permission to <user_work>/repo.git denied to <user_private>.
```

 This is because that only one SSH key is allowed in ssh-agent at a time. You can switch to the `user_private` SSH key in ssh-agent by the following  

```shell
# remove all existing ssh-agent key
$ ssh-add -D
# add the key you want
$ ssh-add ~/.ssh/id_rsa_<user_private>
```

Afterwards, you can push your work to remote!
