/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xa0883be4 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//userfs/tk734/w2k/Downloads/1/Lab2Final/Counter.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_2110339434_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_4000226436_3212880686_p_0(char *t0)
{
    char t13[16];
    char t17[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    int t14;
    unsigned int t15;
    unsigned char t16;
    char *t18;
    unsigned int t19;
    unsigned char t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    xsi_set_current_line(38, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4216);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(39, ng0);
    t3 = (t0 + 1352U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t5 = *((unsigned char *)t3);
    t6 = (t5 == (unsigned char)3);
    if (t6 == 1)
        goto LAB10;

LAB11:    t2 = (unsigned char)0;

LAB12:    if (t2 != 0)
        goto LAB8;

LAB9:    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB15;

LAB16:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(40, ng0);
    t3 = xsi_get_transient_memory(4U);
    memset(t3, 0, 4U);
    t7 = t3;
    memset(t7, (unsigned char)2, 4U);
    t8 = (t0 + 4344);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t3, 4U);
    xsi_driver_first_trans_fast(t8);
    goto LAB6;

LAB8:    xsi_set_current_line(42, ng0);
    t10 = (t0 + 1832U);
    t11 = *((char **)t10);
    t10 = (t0 + 6640U);
    t12 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t17, t11, t10, 1);
    t18 = (t17 + 12U);
    t15 = *((unsigned int *)t18);
    t19 = (1U * t15);
    t20 = (4U != t19);
    if (t20 == 1)
        goto LAB13;

LAB14:    t21 = (t0 + 4344);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t12, 4U);
    xsi_driver_first_trans_fast(t21);
    goto LAB6;

LAB10:    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t1 = (t0 + 6640U);
    t7 = (t0 + 6675);
    t9 = (t13 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 0;
    t10 = (t9 + 4U);
    *((int *)t10) = 3;
    t10 = (t9 + 8U);
    *((int *)t10) = 1;
    t14 = (3 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t15;
    t16 = ieee_p_1242562249_sub_2110339434_1035706684(IEEE_P_1242562249, t4, t1, t7, t13);
    t2 = t16;
    goto LAB12;

LAB13:    xsi_size_not_matching(4U, t19, 0);
    goto LAB14;

LAB15:    xsi_set_current_line(44, ng0);
    t1 = xsi_get_transient_memory(4U);
    memset(t1, 0, 4U);
    t4 = t1;
    memset(t4, (unsigned char)2, 4U);
    t7 = (t0 + 4344);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 4U);
    xsi_driver_first_trans_fast(t7);
    goto LAB6;

}

static void work_a_4000226436_3212880686_p_1(char *t0)
{
    char t25[16];
    char t33[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    unsigned char t18;
    int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned char t23;
    unsigned char t24;
    char *t26;
    int t27;
    unsigned int t28;
    unsigned char t29;
    char *t30;
    unsigned char t31;
    unsigned char t32;
    char *t34;
    char *t35;
    char *t36;
    unsigned int t37;
    unsigned char t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;

LAB0:    xsi_set_current_line(51, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4232);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(52, ng0);
    t3 = (t0 + 1352U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t13 = (0 - 3);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t17 = *((unsigned char *)t1);
    t18 = (t17 == (unsigned char)3);
    if (t18 == 1)
        goto LAB16;

LAB17:    t6 = (unsigned char)0;

LAB18:    if (t6 == 1)
        goto LAB13;

LAB14:    t5 = (unsigned char)0;

LAB15:    if (t5 == 1)
        goto LAB10;

LAB11:    t2 = (unsigned char)0;

LAB12:    if (t2 != 0)
        goto LAB8;

LAB9:    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t13 = (0 - 3);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t6 = *((unsigned char *)t1);
    t17 = (t6 == (unsigned char)3);
    if (t17 == 1)
        goto LAB26;

LAB27:    t5 = (unsigned char)0;

LAB28:    if (t5 == 1)
        goto LAB23;

LAB24:    t2 = (unsigned char)0;

LAB25:    if (t2 != 0)
        goto LAB21;

LAB22:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(53, ng0);
    t3 = xsi_get_transient_memory(4U);
    memset(t3, 0, 4U);
    t7 = t3;
    memset(t7, (unsigned char)2, 4U);
    t8 = (t0 + 4408);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t3, 4U);
    xsi_driver_first_trans_fast(t8);
    goto LAB6;

LAB8:    xsi_set_current_line(55, ng0);
    t26 = (t0 + 1992U);
    t34 = *((char **)t26);
    t26 = (t0 + 6640U);
    t35 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t33, t34, t26, 1);
    t36 = (t33 + 12U);
    t28 = *((unsigned int *)t36);
    t37 = (1U * t28);
    t38 = (4U != t37);
    if (t38 == 1)
        goto LAB19;

LAB20:    t39 = (t0 + 4408);
    t40 = (t39 + 56U);
    t41 = *((char **)t40);
    t42 = (t41 + 56U);
    t43 = *((char **)t42);
    memcpy(t43, t35, 4U);
    xsi_driver_first_trans_fast(t39);
    goto LAB6;

LAB10:    t26 = (t0 + 1192U);
    t30 = *((char **)t26);
    t31 = *((unsigned char *)t30);
    t32 = (t31 == (unsigned char)3);
    t2 = t32;
    goto LAB12;

LAB13:    t8 = (t0 + 1992U);
    t9 = *((char **)t8);
    t8 = (t0 + 6640U);
    t10 = (t0 + 6679);
    t12 = (t25 + 0U);
    t26 = (t12 + 0U);
    *((int *)t26) = 0;
    t26 = (t12 + 4U);
    *((int *)t26) = 3;
    t26 = (t12 + 8U);
    *((int *)t26) = 1;
    t27 = (3 - 0);
    t28 = (t27 * 1);
    t28 = (t28 + 1);
    t26 = (t12 + 12U);
    *((unsigned int *)t26) = t28;
    t29 = ieee_p_1242562249_sub_2110339434_1035706684(IEEE_P_1242562249, t9, t8, t10, t25);
    t5 = t29;
    goto LAB15;

LAB16:    t4 = (t0 + 1832U);
    t7 = *((char **)t4);
    t19 = (3 - 3);
    t20 = (t19 * -1);
    t21 = (1U * t20);
    t22 = (0 + t21);
    t4 = (t7 + t22);
    t23 = *((unsigned char *)t4);
    t24 = (t23 == (unsigned char)3);
    t6 = t24;
    goto LAB18;

LAB19:    xsi_size_not_matching(4U, t37, 0);
    goto LAB20;

LAB21:    xsi_set_current_line(57, ng0);
    t8 = xsi_get_transient_memory(4U);
    memset(t8, 0, 4U);
    t10 = t8;
    memset(t10, (unsigned char)2, 4U);
    t11 = (t0 + 4408);
    t12 = (t11 + 56U);
    t26 = *((char **)t12);
    t30 = (t26 + 56U);
    t34 = *((char **)t30);
    memcpy(t34, t8, 4U);
    xsi_driver_first_trans_fast(t11);
    goto LAB6;

LAB23:    t8 = (t0 + 1192U);
    t9 = *((char **)t8);
    t24 = *((unsigned char *)t9);
    t29 = (t24 == (unsigned char)3);
    t2 = t29;
    goto LAB25;

LAB26:    t4 = (t0 + 1832U);
    t7 = *((char **)t4);
    t19 = (3 - 3);
    t20 = (t19 * -1);
    t21 = (1U * t20);
    t22 = (0 + t21);
    t4 = (t7 + t22);
    t18 = *((unsigned char *)t4);
    t23 = (t18 == (unsigned char)3);
    t5 = t23;
    goto LAB28;

}

static void work_a_4000226436_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(63, ng0);

LAB3:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 4472);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 4248);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_4000226436_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(64, ng0);

LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 4536);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 4264);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_4000226436_3212880686_init()
{
	static char *pe[] = {(void *)work_a_4000226436_3212880686_p_0,(void *)work_a_4000226436_3212880686_p_1,(void *)work_a_4000226436_3212880686_p_2,(void *)work_a_4000226436_3212880686_p_3};
	xsi_register_didat("work_a_4000226436_3212880686", "isim/Counter_tb_isim_beh.exe.sim/work/a_4000226436_3212880686.didat");
	xsi_register_executes(pe);
}
