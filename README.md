# xilinx-summer-camp-project
xilinx暑期学校项目
小组成员：赵拯基、易礼言

具体项目参考项目计划书、设计文档。
本项目设计有两种方案，分别对应project、project2中的工程。

方案一：
将bit文件下载至板卡上后，LED1处于亮起状态。
按下key1，LED1熄灭，进入识别，RGB LED显示对应颜色；
每按下一次key1，在识别与否之间切换状态。

方案二：
将bit文件下载至板卡上后，LED1、LED2均处于熄灭状态。
按下key1，LED1亮起，进入识别状态；LED2亮起，正在对图像流进行识别。
RGB LED显示对应颜色。
对光线等环境要求很高。
