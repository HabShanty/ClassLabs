#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#include<ctype.h>



/*LRU struct*/

typedef struct evictList{
    int RHead;
    int Rtail;
    int Rnext;
    int Rprevious;
    int frequency;

} evictList;





int main()
{

/*Variables*/

    /*Parameter variables*/
    double numSets = 0;    /* # of sets - S */
    double numLines = 0;   /* # of lines per set - E */
    double numBlocks = 0;  /* # of bytes in a block - B */
    double numAddress = 0; /* # of physical address bits - m */
    int hit = 0;           /* # of cycles per hit */
    int miss = 0;          /* # of cycles per miss*/


    double offsetBits = 0;     /* b = # of offset bits = log2(B) */
    double indexBits = 0;       /* s = # of index bits = log2(S)*/

    char evictType[3];
    int evictStyle = 0;
    int lowerIndex = 0;

    /*Cache build variables*/
    double tagBits = 0;        /* t = # of tag bits = m - (s + b)*/
    int sets = 0;
    int lines = 0;

    /* Reads variables */

    unsigned long int hexValue;
    unsigned long int tagNum;
    unsigned long int setNum;
    int index = 0;
    int hex = 0;
    int offset = 0;
    int tag = 0;
    int tagMask = 0;
    int setMask = 0;
    int sentinel = 0;
    int r = 0; /* Row index */
    int c = 0; /* Column index */
    int i = 0; /* # of while loop iterations */
    int misses = 0;
    int hits = 0;
    int dropped = 0;
    int a = 0;
    int eviction = 0;
    int missP = 0;
    int cycles = 0;
    /* Cache size = B * E * S */


/*Constants*/




/* Gather parameters and create cache*/
/* %lf reads a double, %f prints it */
        printf("***Cache Lab!***"
               "\nBegin by entering the parameters of the cache."
               "\nStart with the number of sets in the cache: " );
        scanf("%lf", &numSets);

            indexBits = log2(numSets);
        /*    printf("\nNumber of sets is %f\nNumber of index bits is %f\n", numSets, indexBits); */

        printf("\nNumber of lines: ");
        scanf("%lf", &numLines);

        printf("\nNumber of bytes in a block: ");
        scanf("%lf", &numBlocks);

            offsetBits = log2(numBlocks);
         /*   printf("\nNumber of bytes in a block is %f\nNumber of offset bits is %f\n", numBlocks, offsetBits); */

        printf("\nNumber of physical address bits: ");
        scanf("%lf", &numAddress);



        printf("\nLeast Frequently Used or Least Recently used eviction style? "
               "Enter LFU or LRU\n");




        while(evictStyle < 1)
        {
            scanf("%s", &evictType);


            if((strcmp(evictType, "lfu")) == 0 || (strcmp(evictType,"LFU")) == 0)
            {
                evictStyle = 1;

            }
            else if((strcmp(evictType, "lru")) == 0 || (strcmp(evictType,"LRU")) == 0)
            {
                evictStyle = 2;
            }
            else
            {
                printf("\nInvalid entry, please re-enter eviction style choice\n");
            }

        }

        printf("\nThe number of cycles for a hit: ");
        scanf("%d", &hit);


        printf("\nThe number of cycles for a miss: ");
        scanf("%d", &miss);

        miss = miss + hit;

        /* Cache parameters received, build cache*/

        tagBits = numAddress - (indexBits + offsetBits);
        lines = (int)numLines * 2;


        /* in case numLines is 1 and needs a V box parameter after multiplying */
        if(numLines == 1)
            numLines++;

        sets = (int)numSets;

        int cacheTag[sets][lines];
        int cacheV[sets][lines];
        int cacheEvict[sets][lines];


        for(r = 0; r < sets; r++)
        {
            for(c = 0; c < lines; c ++)
            {
                cacheTag[r][c] = 0;
            }
        }
        for(r = 0; r < sets; r++)
        {
            for(c = 0; c < lines; c ++)
            {
                cacheV[r][c] = 0;
            }
        }
        for(r = 0; r < sets; r++)
        {
            for(c = 0; c < lines; c ++)
            {
                cacheEvict[r][c] = 0;
            }
        }


        /*          Way 0   Way 1    - 2 way 3 set example
         *         [0] [1] [2] [3]
         * Set 0   [V][Tag][V][Tag]
         * Set 1   [V][Tag][V][Tag]
         * Set 2   [V][Tag][V][Tag]
         */



        /*Cache built, reads begin here*/





    while(sentinel != -1)
    {
       /* printf("\nHex value #%d:", i+1);
        printf("\nEnter hex value #%d:", i+1);*/
        scanf("%x", &hexValue);
        sentinel = (int)(hexValue);
        if(sentinel != -1)
        {
            c = 0;

            index = (int) indexBits;
            hex = (int) hexValue;
            offset = (int) offsetBits;
            tag = (int)  tagBits;
            tagMask = 0;
            setMask = 0;

            /*shifts*/
            tagNum = ~(~hex >> (index+offset));
            setNum = ~((~hex << tag) >> (offset+tag));

            /*masks*/
            tagMask = ~((~0 >> tag) << tag);
            setMask = ~((~0 >> index) << index);

            /*Final #'s*/
            tagNum = tagNum & tagMask;
            setNum = setNum & setMask;





            printf("%lu , %lu\n", setNum, tagNum);


            for(c = 0;c < lines;c++);
            {

               if (dropped != 1)
               {
                    if((cacheTag[setNum][c]) == 0 && (cacheV[setNum][c]) == 0)
                    {
                        cacheV[setNum][c] = 1;
                        cacheTag[setNum][c] = tagNum;
                        printf(" M\n");
                        misses++;
                        dropped = 1;

                    }
                    else if((cacheV[setNum][c]) == 1 && (cacheTag[setNum][c]) == tagNum)
                    {
                        printf(" H\n");
                        hits += 1;
                        dropped = 1;
                            if(evictStyle == 1)
                            {
                                cacheEvict[setNum][c] += 1;
                            }
                            else
                            {
                                cacheEvict[setNum][c] = 0;
                            }

                      }
                   }
                   if(evictStyle == 2)
                   {
                        cacheEvict[setNum][c] +=1;

                   }

                }

                if (dropped != 1)
                {

                    for(c = 0;c < lines;c++);
                    {
                            if(c == 0)
                                a = cacheEvict[setNum][c];


                            if (dropped != 1 && evictStyle == 1)
                            {
                                if(a < cacheEvict[setNum][c])
                                {
                                    a = cacheEvict[setNum][c];
                                    eviction = c;
                                }
                            }

                            else if (dropped != 1 && evictStyle == 2)
                            {
                                if(a > cacheEvict[setNum][c])
                                {
                                a = cacheEvict[setNum][c];
                                eviction = c;
                                cacheEvict[setNum][c] = 0 ;
                                }
                            }
                        printf("%d", cacheTag[setNum][c]);

                    }
                cacheTag[setNum][c] = tagNum;
                printf(" M\n");
                misses++;
                dropped = 0;


              }
            dropped = 0;


           }

        }
      cycles = (misses * miss) + (hits * hit);
      missP = misses/(misses + hits);
      printf("%d %d", missP, cycles);


    return 0;
}
