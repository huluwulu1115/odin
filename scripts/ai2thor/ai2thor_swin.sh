set -e

export DETECTRON2_DATASETS="/projects/katefgroup/language_grounding/SEMSEG_100k"
OMP_NUM_THREADS=8 CUDA_VISIBLE_DEVICES=0,1 python train_odin.py  --dist-url='tcp://127.0.0.1:9811' --num-gpus 2 --resume --config-file configs/scannet_context/swin_3d.yaml \
OUTPUT_DIR /projects/katefgroup/language_grounding/bdetr2/arxiv_reproduce/ai2thor_swin200 SOLVER.IMS_PER_BATCH 2 \
SOLVER.CHECKPOINT_PERIOD 500 TEST.EVAL_PERIOD 500 \
INPUT.FRAME_LEFT 7 INPUT.FRAME_RIGHT 7 INPUT.SAMPLING_FRAME_NUM 15 \
MODEL.WEIGHTS '/projects/katefgroup/language_grounding/odin_arxiv/m2f_coco_swin.pkl' \
SOLVER.BASE_LR 1e-4 \
INPUT.IMAGE_SIZE 512 \
MODEL.CROSS_VIEW_CONTEXTUALIZE True \
INPUT.CAMERA_DROP True \
INPUT.STRONG_AUGS True \
INPUT.AUGMENT_3D True \
INPUT.VOXELIZE True \
INPUT.SAMPLE_CHUNK_AUG True \
MODEL.MASK_FORMER.TRAIN_NUM_POINTS 50000 \
MODEL.CROSS_VIEW_BACKBONE True \
DATASETS.TRAIN "('ai2thor_highres_train_single',)" \
DATASETS.TEST "('ai2thor_highres_val_single','ai2thor_highres_train_eval_single')" \
MODEL.PIXEL_DECODER_PANET True \
MODEL.SEM_SEG_HEAD.NUM_CLASSES 117 \
SKIP_CLASSES "[116, 117]" \
MODEL.MASK_FORMER.TEST.SEMANTIC_ON True \
MODEL.FREEZE_BACKBONE False \
SOLVER.TEST_IMS_PER_BATCH 2 \
SAMPLING_STRATEGY "consecutive" \
SOLVER.MAX_ITER 200000 \
DATALOADER.NUM_WORKERS 8 \
DATALOADER.TEST_NUM_WORKERS 2 \
MAX_FRAME_NUM -1 \
INPUT.INPAINT_DEPTH False \
IGNORE_DEPTH_MAX 15.0 \
MODEL.SUPERVISE_SPARSE True \
TEST.EVAL_SPARSE True \
MODEL.MASK_FORMER.DICE_WEIGHT 6.0 \
MODEL.MASK_FORMER.MASK_WEIGHT 15.0 \
USE_WANDB True \
USE_MLP_POSITIONAL_ENCODING True \
INPUT.MIN_SIZE_TEST 512 \
INPUT.MAX_SIZE_TEST 512 \
HIGH_RES_SUBSAMPLE True \
HIGH_RES_INPUT True

# MODEL.WEIGHTS '/projects/katefgroup/language_grounding/odin_arxiv/m2f_coco.pkl' \
# reduce lr at 112k iterations to 1e-5 and get the best checkpoint at 4.5k iterations
