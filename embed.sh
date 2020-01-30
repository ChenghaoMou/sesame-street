#!/bin/sh
PYTHON=/auto/nlg-05/chengham/anaconda3/envs/py37-old/bin/python
BASE=/auto/nlg-05/chengham/ai2-new
EVAL=embed.py
OUTPUT=output
FILE=$OUTPUT/$1-$2-checkpoints/$3/0/_ckpt_epoch_5.ckpt
if [ ! -f "$FILE" ]; then
  FILE=$OUTPUT/$1-$2-checkpoints/$3/0/_ckpt_epoch_3.ckpt
  if [ ! -f "$FILE" ]; then
    FILE=$OUTPUT/$1-$2-checkpoints/$3/0/_ckpt_epoch_2.ckpt
    if [ ! -f "$FILE" ]; then
      FILE=$OUTPUT/$1-$2-checkpoints/$3/0/_ckpt_epoch_1.ckpt
    fi
  fi
fi

$PYTHON -W ignore $EVAL --model_type $1 \
  --model_weight $2 \
  --task_name $3 \
  --task_config_file $BASE/config/tasks.yaml \
  --task_cache_dir $BASE/cache \
  --running_config_file $BASE/config/hyparams.yaml \
  --output_dir $OUTPUT/$1-$2-$3-pred \
  --weights_path $FILE \
  --tags_csv $OUTPUT/$1-$2-log/$3/version_0/meta_tags.csv \
  --dataset $4 \
  --output data/$2-$3-$4-$5.df \
  --embedder $5
