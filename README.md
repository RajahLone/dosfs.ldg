# dosfs.ldg

Library using the LDG system and the dosfs functions, only for floppy disks images (hard disk support is removed), taken from ggnkua’s [Jacknife Total Commander plugin](https://github.com/ggnkua/Jacknife/), and modified a little to rename files/folders (and volume name if present in the FAT).

Used by: KK Commander to handle ST and MSA floppy disks images. 

Other programs can use it, please read KKcmd GFA sources (dfs_ functions) as exemple.

# installation for makefiles

- pre-requisite: different targets of libldg.a in /opt/cross-mint/m68k-atari-mint/lib/

- get [dosfs_r3_src.zip](https://ptonthat.fr/files/dosfs/dosfs_r3_src.zip) and unpack the contents to ./

- dosfs.ldg.xcodeproj is for Xcode 16.0, you may not need it if you use something else.
