Fuse Library for implementing a media cache for Plex reads

media_cache FUSE filesystem intercepts all reads and proxies them based
on file contents.

Mirrors files from one directory to another creating a sparse version
of each file for space savings and dynamically appends to sparsed file when a read() 
operation occurs it.

The cached directory file is 10% the size of the original. 
The mirrored directory is read and a sparse version of each file is written to the 
cached fuse directory in two pieces. 
 
 Sparsed          Actual
[##.....#] ----> [########]
9.5% of the data is in the front and .5% at the end (for moov mp4 files)

When a read() operation occurs on any file in the cached directory
the media_cache daemon proxies the file descriptor (FD) and reads commence from
the sparse file, then a background Go routine starts appending the remaining data
from the mirrored directory

Sparsed(filling up)         Actual
[####...#] <-- Daemon --- [########]

Any seeks() etc beyond the bounds of the sparsed file are proxied and read directly 
from the real (mirrored) file. Meanwhile a Go routine appends the data to
sparsed file eventually proxing the File Descriptor back to the directory of the 
sparsed file.

After a certain configurable time period the sparsed directory files
will be truncated back to 10%.

What is the point of this?
I have a cheap VPS that provides plenty of bandwidth but not disk, in essence
this setup will mirror my 1TB of films at home, where I will only need 100GB
to stream any movie from my VPS and since bandwidth on the VPS is no issue I
can share my Plex collection with much more friends and not worry about my
home bandwidth being maxed out.

TODO:
possibly create server -> server topology and not rely on any filesystem such
as SSHFS/NFS for remote setups
