# %%
"""
calculate log2FC from monte carlo simulation results
"""

 # %%
import os,glob
import pandas as pd
import numpy as np
import statistics

# %%
file = glob.glob('*.stat.txt')
bed = glob.glob('../gtf/binned_up/*.bed')

# %%
fn = [ f.split('.stat')[0] for f in file]

# %%
stat1p = []

for f,b in zip(file,bed):

    bin_num = pd.read_csv(b, sep='\t', header=None).shape[0]

    mc = pd.read_csv(f, sep=' ', header=None)
    splits = list(mc.groupby(0))

    tes = []
    n_log1pfc = []

    for te in splits:
        exp_md = statistics.median(te[1][2][1:1001].tolist())
        obs = float(te[1][2][0:1])
        
        # well this is absolutely useless
        n_log1pfc.append(np.log2(((obs+1)/bin_num)/((exp_md+1)/bin_num)))

        tes.append(te[0])
    
    stat1p.append(pd.Series(n_log1pfc))


df1p = pd.concat(stat1p, axis=1)
df1p.index = tes
df1p.columns = fn

# %%
df1p.to_csv('TE-updnstrm_montecarlo_norm_log1pfc.txt', sep='\t')

