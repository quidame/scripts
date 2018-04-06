# scripts

small scripts doing small things

## description

This is a collection of short scripts (shell, perl and python), some of them
being oneliners (they could be shell aliases), some others doing little bit
more complicated things that could be hard to remember.

## details

These are my favorites, in order of preference:

* `nocomment`  
    For sysadmin tasks, this is helpful to display only the very few lines
    that configure a service or a program without the comments nor the blank
    lines. Some services or applications ship their own facilities to dump
    their configuration (and check it, by the way): `apt`, `postfix`, `bind9`,
    and so on. But some other don't. Examples:

    `nocomment /etc/ssh/sshd_config`
    `nocomment /etc/dhcp/dhclient.conf`
    `nocomment -r /etc/dnsmasq.d`

* `gpg-smartcard-reset-factory`  
    If you plan to write somethihg to automate creation and storage of a GPG
    private keyring on a *g10code* GnuPG compatible smartcard, this piece of
    code may be of help. This it not mine, it comes from Werner Koch on gnupg
    mailling list.
