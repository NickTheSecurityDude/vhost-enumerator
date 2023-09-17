# vhost-enumerator
RedTeam Tool: Basic Subdomain Enumerator for vhosts

I noticed some "false negatives" with GoBuster, so I created this basic vhost enumerator, which picked up a valid vhost which GoBuster missed.

Sample execution:

```
./find_vhosts.sh http stacked.htb /opt/SecLists/Discovery/DNS/subdomains-top1million-5000.txt >vhosts-out.txt
# once you have vhosts-out.txt you can look for anomolies, like this:

# find all 200 http status codes:
cat vhosts-out.txt | awk '$2 == 200'

# find all non-302 http status codes:
cat vhosts-out.txt | awk '$2 != 302'

# find all responses over 350 bytes in size
cat vhosts-out.txt |awk '$3 > 350'
```

Sample output:
```
                                                                                                                            
┌──(kali㉿kali)-[~/htb/tools/nicks-vhost-enumerator]
└─$ cat vhosts-out.txt|wc -l                 
4989
                                                                                                                            
┌──(kali㉿kali)-[~/htb/tools/nicks-vhost-enumerator]
└─$ cat vhosts-out.txt |awk '$3 > 350'   
portfolio 200 30268
                                                                                                                            
┌──(kali㉿kali)-[~/htb/tools/nicks-vhost-enumerator]
└─$ cat vhosts-out.txt |awk '$3 < 350' |wc -l
4988
                                                                                                                            
┌──(kali㉿kali)-[~/htb/tools/nicks-vhost-enumerator]
└─$ cat vhosts-out.txt |awk '$2 == 200'      
portfolio 200 30268
                                                                                                                            
┌──(kali㉿kali)-[~/htb/tools/nicks-vhost-enumerator]
└─$ cat vhosts-out.txt |awk '$2 != 302'
portfolio 200 30268
                                                                                                                            
┌──(kali㉿kali)-[~/htb/tools/nicks-vhost-enumerator]
└─$ cat vhosts-out.txt |awk '$2 == 302' |wc -l
4988
```

For comparison, GoBuster does not find this as valid subdomain, but rather as a redirect:
```
┌──(kali㉿kali)-[~/htb/machines/stacked]
└─$ cat gobuster.vhost.out|grep "Status: 200"
                                                                                                                            
┌──(kali㉿kali)-[~/htb/machines/stacked]
└─$ cat gobuster.vhost.out|grep -v "Status: 200" |wc -l
4989
                                                                                                                            
┌──(kali㉿kali)-[~/htb/machines/stacked]
└─$ cat gobuster.vhost.out| awk '$6 >450' 
                                                                                                                            
┌──(kali㉿kali)-[~/htb/machines/stacked]
└─$ cat gobuster.vhost.out| awk '$6 >150' |wc -l
4989
                                                                                                                            
┌──(kali㉿kali)-[~/htb/machines/stacked]
└─$ cat gobuster.vhost.out|grep  "Status: 302" |wc -l

4948
                                                                                                                            
┌──(kali㉿kali)-[~/htb/machines/stacked]
└─$ cat gobuster.vhost.out|grep "portfolio"
Found: portfolio Status: 302 [Size: 278] [--> http://stacked.htb/]
Found: www.portfolio Status: 302 [Size: 282] [--> http://stacked.htb/]
```
