source activate gmatic
conda env export | sed 's/\/home\/xfu\/miniconda2/\/usr\/local\/anaconda/' > playbooks/environment.yml