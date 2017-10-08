README
This document outlines the steps required to run MATLAB on a cluster using bsub

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creation Date - 2nd Jan 2015
% Author: Soumya Banerjee
% Website: https://sites.google.com/site/neelsoumya/
%
% Example usage:
%   bsub < testmat.lsf
%
% License - BSD 
%
% Acknowledgements - Partners website
%
% Change History - 
%                   2nd  Jan 2015  - Creation by Soumya Banerjee
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

1) ssh into cluster


2) ls -al
edit .bashrc file using vi
change text to

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions
if [ ! -r ~/.ssh/authorized_keys ] ; then
     ssh-keygen -t rsa
     cp .ssh/id_rsa.pub .ssh/authorized_keys
fi


module load matlab-2011b



3)  open a new node
bsub -Is  /bin/bash



4)  create a file named myplot.m with content

h = figure;
t = 0:pi/20:2*pi;
plot('v6',t,sin(t).*2)
saveas(h,'myFigFile','jpg')


5) create a file named testmat.lsf with content

#!/bin/bash

# enable your environment, which will use .bashrc configuration in your home directory
#BSUB -L /bin/bash

# the name of your job showing on the queue system
#BSUB -J myjob

# the following BSUB line specify the queue that you will use,
# please use bqueues command to check the available queues for each toolbox of matlab
# Bioinformatics toolbox, please use matlabbio queue
# Signal Processing toolbox, please use matlabsig queue
# Image Processing toolbox, please use matlabimg queue
# Wavelet toolbox, please use matlabwav queue
# Matlab DCE, please use matlabdce queue (or matlabdce-short for very small jobs like this one)
# Matlab, Optimization and Statistic, please use matlab queue


#BSUB -q matlabdce-short


# the system output and error message output, %J will show as your jobID
#BSUB -o %J.out
#BSUB -e %J.err

#the CPU number that you will collect (Attention: each node has 2 CPU)
#BSUB -n 1


#when job finish that you will get email notification
#BSUB -u YourEmail@email.com
#BSUB -N


# Finally, Start the program
matlab < myplot.m






5) RUN/ START the JOB

bsub < testmat.lsf



6) check status

bjobs -u all



7) kill jobs

bkill <process_id>