# vhost-enumerator
RedTeam Tool: Basic Subdomain Enumerator for vhosts

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

Sample output, portfolio is the only expected valid 200:
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
