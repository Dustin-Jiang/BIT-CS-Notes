# 生成模型

## 可视化结果笔记

```bash
python test.py \
    --dataroot ./datasets/facades \
    --name test_env \
    --model pix2pix \
    --direction BtoA \
    --num_test 5
```

结果：运行 test，生成 html：

![image-20251222114617208](C:\Users\SertralineFighter\AppData\Roaming\Typora\typora-user-images\image-20251222114617208.png)

一共 5 份

注意：方向 BtoA

## 可视化

可视化指令

```bash
python scripts/visualize_training_log.py --name city_p2p_lsgan_change1 --smooth_window 20
```

## 不同参数实验

### 实验 1

vanilla，100epoch，8batch size

```bash
python train.py --dataroot ./datasets/cityscapes/ --name city_p2p_test --model pix2pix --direction BtoA --n_epochs 50 --n_epochs_decay 50 --batch_size 8 --gan_mode vanilla
```

### 实验 2

lsgan，100epoch，16batch size

```bash
python train.py --dataroot ./datasets/cityscapes/ --name city_p2p_lsgan --model pix2pix --direction BtoA --n_epochs 50 --n_epochs_decay 50 --batch_size 16 --gan_mode lsgan --fid_eval_freq 10
```

轮廓清晰，没有细节

观察 0 到 100epoch 图像，发现轮廓优化上花了过多无用功，而细节一直没有提升

### 实验 3

lsgan，100epoch，16batch size

修改 loss 参数，L1 为 50. 尝试解决无细节问题

```bash
python train.py --dataroot ./datasets/cityscapes/ --name city_p2p_lsgan_L150 --model pix2pix --direction BtoA --n_epochs 50 --n_epochs_decay 50 --batch_size 16 --gan_mode lsgan --fid_eval_freq 10 --lambda_L1 50
```

### 实验 4

```bash
python train.py --dataroot ./datasets/cityscapes/ --name city_p2p_wgangp --model pix2pix --direction BtoA --n_epochs 50 --n_epochs_decay 50 --batch_size 16 --gan_mode wgangp --fid_eval_freq 10
```

wgangp 太敏感了，这个参数对他很不合适，直接训练崩溃了。调整参数

### 实验 5 ❌

```bash
python train.py --dataroot ./datasets/cityscapes/ --name city_p2p_wgangp_changed --model pix2pix --direction BtoA --n_epochs 80 --n_epochs_decay 80 --batch_size 16 --gan_mode wgangp --fid_eval_freq 10 --lr 0.0001 --beta1 0.0 --lambda_L1 50 
```

没有什么改进，还是崩溃了，wgangp 怎么这么难用

### 实验 6

重新用回 lsgan，试试调参

```bash
python train.py --dataroot ./datasets/cityscapes/ --name city_p2p_lsgan_change1 --model pix2pix --direction BtoA --n_epochs 100 --n_epochs_decay 100 --batch_size 8 --gan_mode lsgan --fid_eval_freq 10 --lambda_L1 100 --pool_size 50 --lr 0.0002 --ndf 128 --n_layers_D 4
```

跑一下看看，主要看 ssim 能否回升