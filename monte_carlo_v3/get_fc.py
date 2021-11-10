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

# %%
tf = [ f.split('.stat')[0] for f in file]

# %%
stat = []
stat1p = []

for f in file:
    mc = pd.read_csv(f, sep=' ', header=None)
    splits = list(mc.groupby(0))

    tes = []
    logfc = []
    log1pfc = []

    for te in splits:
        exp_md = statistics.median(te[1][2][1:1001].tolist())
        obs = float(te[1][2][0:1])

        if exp_md * obs != 0:
            logfc.append(np.log2(obs/exp_md))
        else:
            logfc.append('NA')
        
        log1pfc.append(np.log2((obs+1)/(exp_md+1)))

        tes.append(te[0])
    
    stat.append(pd.Series(logfc))
    stat1p.append(pd.Series(log1pfc))

df = pd.concat(stat, axis=1)
df.index = tes
df.columns = tf

df1p = pd.concat(stat1p, axis=1)
df1p.index = tes
df1p.columns = tf

# %%
df.to_csv('TE-updnstrm_montecarlo_logfc.txt', sep='\t')
df1p.to_csv('TE-updnstrm_montecarlo_log1pfc.txt', sep='\t')

