% LSOF(shell) Um Pages | Um Pages
% 
% September 15, 2018
# NAME
lsof -- List open files

# OPTIONS

+|-L
    Enable or disable display of link counts. If +L is followed by a number, filters based on files that have less than that many links

+|-r [t]
    Enable repeat mode every t seconds (default 15). If +, ends when no files are found, if - then it's endless

# EXAMPLES

lsof +L 1

    Displays files that have no links (deleted files that are still held onto by processes)

lsof -i :80

    Displays process listening on port 80

lsof /var/log/messages

    Find processes that have /var/log/messages open
