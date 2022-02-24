from email import header
from fileinput import filename
import os,glob
import sys
import pandas as pd
import numpy as np
import pybedtools as pb

peakfile = glob.glob('../*_gene.bed')

genome = dict(pd.read_csv('mm10.chrom.sizes', sep='\t', header=None).values)


for p in peakfile:
    peak = pd.read_csv(p, sep='\t', header=None)
    peak_c = pb.BedTool(p)

    ## pybedtools flank doesn't work either
    # flanked = peak.flank(g='mm10.chrom.sizes', l=1000, r=0, s=False)

    # + strand
    peak[1] = np.where(peak[4] == '+', peak[1].values - 1000, peak[1])
    peak[2] = np.where(peak[4] == '+', peak[1].values + 1000, peak[2])

    peak[2] = np.where(peak[4] == '-', peak[2].values + 1000, peak[2])
    peak[1] = np.where(peak[4] == '-', peak[2].values - 1000, peak[1])

    # remove interval out of range
    peak = peak[peak[1] > 0]
    peak['max'] = peak[0].map(genome)
    peak = peak[peak[2] <= peak['max']]

    peak.drop('max', axis=1, inplace=True)

    # peak_subbed = pb.BedTool.from_dataframe(peak)\
        # .to_dataframe(disable_auto_names=True, header=None)
        #.subtract(peak_c,s=True)\
        #.window_maker(g='mm10.chrom.sizes',w=100)

    fname = os.path.split(p)[1].replace('.bed','') + '_flank.bed'

    peak.to_csv(fname, sep='\t', header=None, index=False)


    
