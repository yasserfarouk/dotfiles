FasdUAS 1.101.10   ��   ��    k             i         I     �� 	��
�� .aevtoappnull  �   � **** 	 o      ���� 0 arg  ��    k    J 
 
     l      ��  ��    N H  ************************** Setup Variables **************************      �   �     * * * * * * * * * * * * * * * * * * * * * * * * * *   S e t u p   V a r i a b l e s   * * * * * * * * * * * * * * * * * * * * * * * * * *        l     ��������  ��  ��        l     ��  ��    . ( Check if any Default Values are missing     �   P   C h e c k   i f   a n y   D e f a u l t   V a l u e s   a r e   m i s s i n g      l     ��������  ��  ��        l     ��  ��      FOR unsplash.scpt ONLY     �   .   F O R   u n s p l a s h . s c p t   O N L Y      r        !   n      " # " 1   	 ��
�� 
psxp # l    	 $���� $ b     	 % & % l     '���� ' I    �� ( )
�� .earsffdralis        afdr (  f      ) �� *��
�� 
rtyp * m    ��
�� 
TEXT��  ��  ��   & m     + + � , ,  : :��  ��   ! o      ���� 0 user_project_path     - . - r     / 0 / c     1 2 1 b     3 4 3 o    ���� 0 user_project_path   4 m     5 5 � 6 6 " . u n s p l a s h - s o u r c e / 2 m    ��
�� 
TEXT 0 o      ���� 0 
configpath 
configPath .  7 8 7 l   ��������  ��  ��   8  9 : 9 l   �� ; <��   ; #  Get values from config.plist    < � = = :   G e t   v a l u e s   f r o m   c o n f i g . p l i s t :  > ? > r    # @ A @ I   !�� B C
�� .sysoexecTEXT���     TEXT B b     D E D b     F G F m     H H � I I  d e f a u l t s   r e a d   G o    ���� 0 
configpath 
configPath E m     J J � K K > c o n f i g . p l i s t   u s e r _ d e s k t o p _ w i d t h C �� L��
�� 
rtyp L m    ��
�� 
TEXT��   A o      ���� 0 user_desktop_width   ?  M N M r   $ 1 O P O I  $ /�� Q R
�� .sysoexecTEXT���     TEXT Q b   $ ) S T S b   $ ' U V U m   $ % W W � X X  d e f a u l t s   r e a d   V o   % &���� 0 
configpath 
configPath T m   ' ( Y Y � Z Z @ c o n f i g . p l i s t   u s e r _ d e s k t o p _ h e i g h t R �� [��
�� 
rtyp [ m   * +��
�� 
TEXT��   P o      ���� 0 user_desktop_height   N  \ ] \ l  2 2��������  ��  ��   ]  ^ _ ^ Z   2 E ` a���� ` A  2 7 b c b n   2 5 d e d 1   3 5��
�� 
leng e o   2 3���� 0 user_desktop_width   c m   5 6����  a L   : A f f n  : @ g h g I   ; @�� i���� (0 promptmissingwidth promptMissingWidth i  j�� j o   ; <���� 0 
configpath 
configPath��  ��   h  f   : ;��  ��   _  k l k l  F F��������  ��  ��   l  m n m Z   F Y o p���� o A  F K q r q n   F I s t s 1   G I��
�� 
leng t o   F G���� 0 user_desktop_height   r m   I J����  p L   N U u u n  N T v w v I   O T�� x���� *0 promptmissingheight promptMissingHeight x  y�� y o   O P���� 0 
configpath 
configPath��  ��   w  f   N O��  ��   n  z { z l  Z Z�� | }��   |    End of unsplash.scpt ONLY    } � ~ ~ 4   E n d   o f   u n s p l a s h . s c p t   O N L Y {   �  l  Z Z��������  ��  ��   �  � � � l  Z Z�� � ���   �  
 Variables    � � � �    V a r i a b l e s �  � � � r   Z e � � � c   Z a � � � b   Z _ � � � o   Z [���� 0 user_project_path   � m   [ ^ � � � � �  i m a g e s / � m   _ `��
�� 
TEXT � o      ���� 0 images_directory   �  � � � r   f s � � � c   f o � � � b   f m � � � o   f i���� 0 images_directory   � m   i l � � � � � & c u r r e n t - w a l l p a p e r s / � m   m n��
�� 
TEXT � o      ���� 0 current_directory   �  � � � r   t � � � � c   t } � � � b   t { � � � o   t w���� 0 images_directory   � m   w z � � � � � " s a v e d - w a l l p a p e r s / � m   { |��
�� 
TEXT � o      ���� 0 saved_directory   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   API Credentials    � � � �     A P I   C r e d e n t i a l s �  � � � r   � � � � � I  � ��� � �
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � m   � � � � � � �  d e f a u l t s   r e a d   � o   � ����� 0 
configpath 
configPath � m   � � � � � � � : c o n f i g . p l i s t   u n s p l a s h _ a p i _ u r l � �� ���
�� 
rtyp � m   � ���
�� 
TEXT��   � o      ���� 0 unsplash_api_url   �  � � � r   � � � � � I  � ��� � �
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � m   � � � � � � �  d e f a u l t s   r e a d   � o   � ����� 0 
configpath 
configPath � m   � � � � � � � F c o n f i g . p l i s t   u n s p l a s h _ a p i _ c l i e n t _ i d � �� ���
�� 
rtyp � m   � ���
�� 
TEXT��   � o      ���� 0 unsplash_api_client_id   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Check if initial run    � � � � *   C h e c k   i f   i n i t i a l   r u n �  � � � r   � � � � � I  � ��� � �
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � m   � � � � � � �  d e f a u l t s   r e a d   � o   � ����� 0 
configpath 
configPath � m   � � � � � � � B c o n f i g . p l i s t   u n s p l a s h _ i n i t i a l _ r u n � �� ���
�� 
rtyp � m   � ���
�� 
TEXT��   � o      ���� 0 unsplash_initial_run   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � B < Is the network required for the command? (False for "load")    � � � � x   I s   t h e   n e t w o r k   r e q u i r e d   f o r   t h e   c o m m a n d ?   ( F a l s e   f o r   " l o a d " ) �  � � � r   � � � � � m   � ���
�� boovtrue � o      ���� "0 networkrequired networkRequired �  � � � Z   �7 � ����� � ?   � � � � � l  � � ����� � I  � ��� ���
�� .corecnte****       **** � o   � ����� 0 arg  ��  ��  ��   � m   � �����   � Z   �3 � ����� � G   �' � � � G   � � � � G   � � � � � l  � � ����� � =  � � � � � n  � � � � � 4  � ��� �
�� 
cobj � m   � �����  � o   � ����� 0 arg   � m   � �   �  l o a d��  ��   � l  � ���� =  � � n  � � 4  � ��~
�~ 
cobj m   � ��}�}  o   � ��|�| 0 arg   m   � � �		 
 s a v e d��  �   � l  �
�{�z
 F   � ?  � � l  � ��y�x I  � ��w�v
�w .corecnte****       **** o   � ��u�u 0 arg  �v  �y  �x   m   � ��t�t   =  �  n  � � 4  � ��s
�s 
cobj m   � ��r�r  o   � ��q�q 0 arg   m   � � � 
 w i d t h�{  �z   � l #�p�o F  # ?  l �n�m I �l�k
�l .corecnte****       **** o  �j�j 0 arg  �k  �n  �m   m  �i�i   =   n !"! 4 �h#
�h 
cobj# m  �g�g " o  �f�f 0 arg    m  $$ �%%  h e i g h t�p  �o   � r  */&'& m  *+�e
�e boovfals' o      �d�d "0 networkrequired networkRequired��  ��  ��  ��   � ()( l 88�c�b�a�c  �b  �a  ) *+* l 88�`�_�^�`  �_  �^  + ,-, l 88�]�\�[�]  �\  �[  - ./. Z  8�01�Z�Y0 G  8K232 = 8=454 o  8;�X�X "0 networkrequired networkRequired5 m  ;<�W
�W boovtrue3 = @G676 o  @C�V�V 0 unsplash_initial_run  7 m  CF88 �99  y e s1 l N�:;<: k  N�== >?> l NN�U@A�U  @ Y S if client_id is blank (probably first time running project) then fetch credentials   A �BB �   i f   c l i e n t _ i d   i s   b l a n k   ( p r o b a b l y   f i r s t   t i m e   r u n n i n g   p r o j e c t )   t h e n   f e t c h   c r e d e n t i a l s? CDC Z  NuEF�T�SE G  NcGHG A NUIJI n  NSKLK 1  QS�R
�R 
lengL o  NQ�Q�Q 0 unsplash_api_client_id  J m  ST�P�P H = X_MNM o  X[�O�O 0 unsplash_initial_run  N m  [^OO �PP  y e sF k  fqQQ RSR l ff�NTU�N  T J D Try to repair API credentials. REMOVE NEXT LINE FOR ALFRED WORKFLOW   U �VV �   T r y   t o   r e p a i r   A P I   c r e d e n t i a l s .   R E M O V E   N E X T   L I N E   F O R   A L F R E D   W O R K F L O WS WXW n flYZY I  gl�M[�L�M .0 refreshapicredentials refreshApiCredentials[ \�K\ o  gh�J�J 0 
configpath 
configPath�K  �L  Z  f  fgX ]�I] L  mq^^ m  mp__ �``� # 	 
 # 	 I t   l o o k s   l i k e   t h i s   i s   y o u r   f i r s t   t i m e   r u n n i n g 
 # 	 o n e   o f   t h e   ` W a l l p a p e r s   f r o m   U n s p l a s h `   c o m m a n d s . 
 # 	 
 # 	 I   h a v e   a u t o m a t i c a l l y   u p d a t e d   t h e   n e c e s s a r y   A P I   k e y s   a n d 
 # 	 y o u ' r e   s e t u p   i s   c o m p l e t e !   P l e a s e   t r y   r u n n i n g   y o u r 
 # 	 c o m m a n d   a g a i n . 
 # 	 
 # 	 I f   t h i s   m e s s a g e   p e r s i s t s ,   o p e n   a n   i s s u e   o n   G i t H u b   f o r   s u p p o r t : 
 # 	 h t t p s : / / g i t h u b . c o m / a d a m d e h a v e n / W a l l p a p e r s - f r o m - U n s p l a s h / i s s u e s 
 # 	�I  �T  �S  D aba l vv�Hcd�H  c _ Y Check network connectivity (e.g. user can access the required URLs, including redirects)   d �ee �   C h e c k   n e t w o r k   c o n n e c t i v i t y   ( e . g .   u s e r   c a n   a c c e s s   t h e   r e q u i r e d   U R L s ,   i n c l u d i n g   r e d i r e c t s )b fgf r  v�hih I v��Gjk
�G .sysoexecTEXT���     TEXTj b  v�lml b  v�non b  v�pqp b  v�rsr b  v�tut b  v�vwv b  v�xyx b  v}z{z m  vy|| �}} B c a s e   " $ ( c u r l   - s   - - m a x - t i m e   2   - I   '{ o  y|�F�F 0 unsplash_api_url  y m  }�~~ � 0 p h o t o s / r a n d o m ? c l i e n t _ i d =w o  ���E�E 0 unsplash_api_client_id  u m  ���� ���  & w =s o  ���D�D 0 user_desktop_width  q m  ���� ���  & h =o o  ���C�C 0 user_desktop_height  m m  ���� ���b '   |   s e d   ' s / ^ [ ^   ] *     * \ ( [ 0 - 9 ] \ ) . * / \ 1 / ;   1 q ' ) "   i n   [ 2 3 ] )   e c h o   " H T T P   c o n n e c t i o n   O K " ; ;   5 )   e c h o   " W e b   p r o x y   w i l l   n o t   a l l o w   c o n n e c t i o n " ; ;   * )   e c h o   " T h e   n e t w o r k   i s   d o w n   o r   v e r y   s l o w " ; ;   e s a ck �B��A
�B 
rtyp� m  ���@
�@ 
TEXT�A  i o      �?�? 0 apiconnection apiConnectiong ��� r  ����� I ���>��
�> .sysoexecTEXT���     TEXT� m  ���� ���H c a s e   " $ ( c u r l   - s   - - m a x - t i m e   2   - I   ' h t t p : / / a d a m d e h a v e n . c o m / u n s p l a s h / r e p a i r - a p i / ? a p p = W a l l p a p e r s - f r o m - U n s p l a s h & v a l u e = u r l '   |   s e d   ' s / ^ [ ^   ] *     * \ ( [ 0 - 9 ] \ ) . * / \ 1 / ;   1 q ' ) "   i n   [ 2 3 ] )   e c h o   " H T T P   c o n n e c t i o n   O K " ; ;   5 )   e c h o   " W e b   p r o x y   w i l l   n o t   a l l o w   c o n n e c t i o n " ; ;   * )   e c h o   " T h e   n e t w o r k   i s   d o w n   o r   v e r y   s l o w " ; ;   e s a c� �=��<
�= 
rtyp� m  ���;
�; 
TEXT�<  � o      �:�: .0 credentialsconnection credentialsConnection� ��9� Z  ������8� G  ����� = ����� o  ���7�7 0 apiconnection apiConnection� m  ���� ��� F W e b   p r o x y   w i l l   n o t   a l l o w   c o n n e c t i o n� = ����� o  ���6�6 .0 credentialsconnection credentialsConnection� m  ���� ��� F W e b   p r o x y   w i l l   n o t   a l l o w   c o n n e c t i o n� k  ���� ��� l ���5���5  � 0 * User cannot access API urls through proxy   � ��� T   U s e r   c a n n o t   a c c e s s   A P I   u r l s   t h r o u g h   p r o x y� ��4� L  ���� m  ���� ���� # 	 
 # 	 T h e r e   a p p e a r s   t o   b e   a n   i s s u e   w i t h   y o u r   n e t w o r k 
 # 	 a c c e s s i n g   t h e   U n s p l a s h   A P I   r e l a t e d   t o   y o u r   
 # 	 n e t w o r k ' s   p r o x y   s e t t i n g s   o r   f i r e w a l l . 
 # 	 
 # 	 T r y   c o n n e c t i n g   t o   a   d i f f e r e n t   n e t w o r k   o r   
 # 	 c h a n g i n g   y o u r   n e t w o r k ' s   p r o x y   s e t t i n g s . 
 # 	 
 # 	 I f   t h e   i s s u e   p e r s i s t s ,   o p e n   a n   i s s u e   o n   G i t H u b   f o r   s u p p o r t : 
 # 	 h t t p s : / / g i t h u b . c o m / a d a m d e h a v e n / W a l l p a p e r s - f r o m - U n s p l a s h / i s s u e s 
 # 	�4  � ��� G  ����� = ����� o  ���3�3 0 apiconnection apiConnection� m  ���� ��� @ T h e   n e t w o r k   i s   d o w n   o r   v e r y   s l o w� = ����� o  ���2�2 .0 credentialsconnection credentialsConnection� m  ���� ��� @ T h e   n e t w o r k   i s   d o w n   o r   v e r y   s l o w� ��1� k  ���� ��� l ���0���0  � M G User cannot access API urls because of down network or slow connection   � ��� �   U s e r   c a n n o t   a c c e s s   A P I   u r l s   b e c a u s e   o f   d o w n   n e t w o r k   o r   s l o w   c o n n e c t i o n� ��/� L  ���� m  ���� ���� # 	 
 # 	 T h e r e   a p p e a r s   t o   b e   a n   i s s u e   w i t h   y o u r   n e t w o r k 
 # 	 c o n n e c t i o n .   Y o u r   c o n n e c t i o n   i s   t o o   s l o w ,   o r   m o r e 
 # 	 l i k e l y ,   y o u r   i n t e r n e t   c o n n e c t i o n   i s   d o w n . 
 # 
 # 	 T r o u b l e s h o o t   y o u r   i n t e r n e t   c o n n e c t i o n   o r 
 # 	 t r y   c o n n e c t i n g   t o   a   d i f f e r e n t   n e t w o r k . 
 # 	 
 # 	 I f   t h e   i s s u e   p e r s i s t s ,   o p e n   a n   i s s u e   o n   G i t H u b   f o r   s u p p o r t : 
 # 	 h t t p s : / / g i t h u b . c o m / a d a m d e h a v e n / W a l l p a p e r s - f r o m - U n s p l a s h / i s s u e s 
 # 	�/  �1  �8  �9  ; } w this line only for Terminal commands, but logic contained within (other than first if statement) is for Alfred as well   < ��� �   t h i s   l i n e   o n l y   f o r   T e r m i n a l   c o m m a n d s ,   b u t   l o g i c   c o n t a i n e d   w i t h i n   ( o t h e r   t h a n   f i r s t   i f   s t a t e m e n t )   i s   f o r   A l f r e d   a s   w e l l�Z  �Y  / ��� l ���.�-�,�.  �-  �,  � ��� l  ���+���+  � L F  ************************** End Variables **************************    � ��� �     * * * * * * * * * * * * * * * * * * * * * * * * * *   E n d   V a r i a b l e s   * * * * * * * * * * * * * * * * * * * * * * * * * *  � ��� l ���*�)�(�*  �)  �(  � ��'� Z  �J����� = ����� l ����&�%� I ���$��#
�$ .corecnte****       ****� o  ���"�" 0 arg  �#  �&  �%  � m  ���!�!  � k  ��� ��� l ��� ���   �   No arguments   � ���    N o   a r g u m e n t s� ��� l ������  �   $ unsplash   � ���    $   u n s p l a s h� ��� I  ����� &0 fetchrandomimages fetchRandomImages� ��� o  ���� 0 arg  � ��� o  ���� 0 
configpath 
configPath� ��� o  ��� 0 unsplash_api_url  � ��� o  �� 0 unsplash_api_client_id  � ��� o  �� 0 user_project_path  � ��� o  �� 0 user_desktop_width  � ��� o  �� 0 user_desktop_height  � ��� o  �� 0 images_directory  � ��� o  �� 0 current_directory  �  �  �  � ��� F  /��� = ��� l ���� I ���
� .corecnte****       ****� o  �� 0 arg  �  �  �  � m  �� � = !+��� n !'��� 4 "'��
� 
cobj� m  %&�
�
 � o  !"�	�	 0 arg  � m  '*�� ���  l o a d� � � k  2A  l 22��     $ unsplash load    �     $   u n s p l a s h   l o a d � I  2A��� .0 loadrandomsavedimages loadRandomSavedImages 	
	 o  34�� 0 arg  
  o  45�� 0 
configpath 
configPath  o  58�� 0 saved_directory   � o  8;� �  0 current_directory  �  �  �     F  D\ = DK l DI���� I DI����
�� .corecnte****       **** o  DE���� 0 arg  ��  ��  ��   m  IJ����  = NX n NT 4 OT��
�� 
cobj m  RS����  o  NO���� 0 arg   m  TW �  l o a d   k  _x!! "#" l __��$%��  $   $ unsplash load [string]   % �&& 2   $   u n s p l a s h   l o a d   [ s t r i n g ]# '(' r  _k)*) c  _g+,+ n _e-.- 4 `e��/
�� 
cobj/ m  cd���� . o  _`���� 0 arg  , m  ef��
�� 
TEXT* o      ���� 0 passedstring passedString( 0��0 L  lx11 b  lw232 b  ls454 m  lo66 �77 � # 	 
 # 	 I t   l o o k s   l i k e   y o u ' r e   t r y i n g   t o   u s e   a   s a v e d 
 # 	 i m a g e .   T r y   a g a i n   r u n n i n g   t h e   ' s a v e d '   c o m m a n d : 
 # 	 $   u n s p l a s h   s a v e d  5 o  or���� 0 passedstring passedString3 m  sv88 �99  
 # 	��    :;: F  {�<=< = {�>?> l {�@����@ I {���A��
�� .corecnte****       ****A o  {|���� 0 arg  ��  ��  ��  ? m  ������ = = ��BCB n ��DED 4 ����F
�� 
cobjF m  ������ E o  ������ 0 arg  C m  ��GG �HH  f e a t u r e d; IJI k  ��KK LML l ����NO��  N   $ unsplash featured   O �PP (   $   u n s p l a s h   f e a t u r e dM Q��Q I  ����R���� &0 fetchrandomimages fetchRandomImagesR STS o  ������ 0 arg  T UVU o  ������ 0 
configpath 
configPathV WXW o  ������ 0 unsplash_api_url  X YZY o  ������ 0 unsplash_api_client_id  Z [\[ o  ������ 0 user_project_path  \ ]^] o  ������ 0 user_desktop_width  ^ _`_ o  ������ 0 user_desktop_height  ` aba o  ������ 0 images_directory  b c��c o  ������ 0 current_directory  ��  ��  ��  J ded G  ��fgf = ��hih l ��j����j I ����k��
�� .corecnte****       ****k o  ������ 0 arg  ��  ��  ��  i m  ������ g ? ��lml l ��n����n I ����o��
�� .corecnte****       ****o o  ������ 0 arg  ��  ��  ��  m m  ������ e pqp k  ��rr sts l ����uv��  u   Check for Bash Errors   v �ww ,   C h e c k   f o r   B a s h   E r r o r st x��x n ��yzy I  ����{���� (0 checkforbasherrors checkForBashErrors{ |}| o  ������ 0 arg  } ~��~ o  ������ 0 
configpath 
configPath��  ��  z  f  ����  q � G  ����� G  ����� = ����� l �������� I �������
�� .corecnte****       ****� o  ������ 0 arg  ��  ��  ��  � m  ������ � = ����� n ����� 4 �����
�� 
cobj� m  ������ � o  ������ 0 arg  � m  ���� ���  l o a d� = ����� n ����� 4 �����
�� 
cobj� m  ������ � o  ������ 0 arg  � m  ���� ���  f e a t u r e d� ���� Z  �@������ = �	��� n ���� 4  ���
�� 
cobj� m  ���� � o  � ���� 0 arg  � m  �� ���  d e s k t o p� k  $�� ��� l ������  � #  $ unsplash desktop [integer]   � ��� :   $   u n s p l a s h   d e s k t o p   [ i n t e g e r ]� ��� l ������  �   $ unsplash desktop 2   � ��� *   $   u n s p l a s h   d e s k t o p   2� ���� I  $������� 80 fetchrandomimagefordesktop fetchRandomImageForDesktop� ��� o  ���� 0 arg  � ��� o  ���� 0 
configpath 
configPath� ��� o  ���� 0 unsplash_api_url  � ��� o  ���� 0 unsplash_api_client_id  � ��� o  ���� 0 user_project_path  � ��� o  ���� 0 user_desktop_width  � ��� o  ���� 0 user_desktop_height  � ��� o  ���� 0 images_directory  � ���� o  ���� 0 current_directory  ��  ��  ��  � ��� = '1��� n '-��� 4 (-���
�� 
cobj� m  +,���� � o  '(���� 0 arg  � m  -0�� ��� 
 f e t c h� ��� k  4L�� ��� l 44������  �    $ unsplash fetch [string]   � ��� 4   $   u n s p l a s h   f e t c h   [ s t r i n g ]� ��� l 44������  � #  $ unsplash fetch U5rMrSI7Pn4   � ��� :   $   u n s p l a s h   f e t c h   U 5 r M r S I 7 P n 4� ���� I  4L������� (0 fetchspecificimage fetchSpecificImage� ��� o  56���� 0 arg  � ��� o  67���� 0 
configpath 
configPath� ��� o  7:���� 0 unsplash_api_url  � ��� o  :=���� 0 unsplash_api_client_id  � ��� o  =>���� 0 user_project_path  � ��� o  >?���� 0 user_desktop_width  � ��� o  ?@���� 0 user_desktop_height  � ��� o  @C���� 0 images_directory  � ���� o  CF���� 0 current_directory  ��  ��  ��  � ��� = OY��� n OU��� 4 PU���
�� 
cobj� m  ST���� � o  OP���� 0 arg  � m  UX�� ���  s e a r c h� ��� k  \t�� ��� l \\������  � 1 + $ unsplash search [comma-separated string]   � ��� V   $   u n s p l a s h   s e a r c h   [ c o m m a - s e p a r a t e d   s t r i n g ]� ��� l \\������  �    $ unsplash search sunrise   � ��� 4   $   u n s p l a s h   s e a r c h   s u n r i s e� � � l \\����   %  $ unsplash search sunrise,city    � >   $   u n s p l a s h   s e a r c h   s u n r i s e , c i t y  �� I  \t������ &0 fetchrandomimages fetchRandomImages  o  ]^���� 0 arg   	 o  ^_���� 0 
configpath 
configPath	 

 o  _b���� 0 unsplash_api_url    o  be���� 0 unsplash_api_client_id    o  ef���� 0 user_project_path    o  fg���� 0 user_desktop_width    o  gh���� 0 user_desktop_height    o  hk���� 0 images_directory   �� o  kn���� 0 current_directory  ��  ��  ��  �  = w� n w} 4 x}�
� 
cobj m  {|�~�~  o  wx�}�} 0 arg   m  }� �  u s e r n a m e  !  k  ��"" #$# l ���|%&�|  % #  $ unsplash username [string]   & �'' :   $   u n s p l a s h   u s e r n a m e   [ s t r i n g ]$ ()( l ���{*+�{  * "  $ unsplash username stvcrtr   + �,, 8   $   u n s p l a s h   u s e r n a m e   s t v c r t r) -�z- I  ���y.�x�y &0 fetchrandomimages fetchRandomImages. /0/ o  ���w�w 0 arg  0 121 o  ���v�v 0 
configpath 
configPath2 343 o  ���u�u 0 unsplash_api_url  4 565 o  ���t�t 0 unsplash_api_client_id  6 787 o  ���s�s 0 user_project_path  8 9:9 o  ���r�r 0 user_desktop_width  : ;<; o  ���q�q 0 user_desktop_height  < =>= o  ���p�p 0 images_directory  > ?�o? o  ���n�n 0 current_directory  �o  �x  �z  ! @A@ = ��BCB n ��DED 4 ���mF
�m 
cobjF m  ���l�l E o  ���k�k 0 arg  C m  ��GG �HH  c o l l e c t i o nA IJI k  ��KK LML l ���jNO�j  N %  $ unsplash collection [string]   O �PP >   $   u n s p l a s h   c o l l e c t i o n   [ s t r i n g ]M QRQ l ���iST�i  S #  $ unsplash collection 139675   T �UU :   $   u n s p l a s h   c o l l e c t i o n   1 3 9 6 7 5R VWV l ���hXY�h  X 5 / Does not currently support curated collections   Y �ZZ ^   D o e s   n o t   c u r r e n t l y   s u p p o r t   c u r a t e d   c o l l e c t i o n sW [�g[ I  ���f\�e�f &0 fetchrandomimages fetchRandomImages\ ]^] o  ���d�d 0 arg  ^ _`_ o  ���c�c 0 
configpath 
configPath` aba o  ���b�b 0 unsplash_api_url  b cdc o  ���a�a 0 unsplash_api_client_id  d efe o  ���`�` 0 user_project_path  f ghg o  ���_�_ 0 user_desktop_width  h iji o  ���^�^ 0 user_desktop_height  j klk o  ���]�] 0 images_directory  l m�\m o  ���[�[ 0 current_directory  �\  �e  �g  J non = ��pqp n ��rsr 4 ���Zt
�Z 
cobjt m  ���Y�Y s o  ���X�X 0 arg  q m  ��uu �vv  s a v eo wxw k  ��yy z{z l ���W|}�W  |    $ unsplash save [integer]   } �~~ 4   $   u n s p l a s h   s a v e   [ i n t e g e r ]{ � l ���V���V  �   $ unsplash save 2   � ��� $   $   u n s p l a s h   s a v e   2� ��U� I  ���T��S�T $0 savedesktopimage saveDesktopImage� ��� o  ���R�R 0 arg  � ��� o  ���Q�Q 0 
configpath 
configPath� ��� o  ���P�P 0 unsplash_api_url  � ��� o  ���O�O 0 unsplash_api_client_id  � ��� o  ���N�N 0 user_project_path  � ��� o  ���M�M 0 user_desktop_width  � ��� o  ���L�L 0 user_desktop_height  � ��� o  ���K�K 0 images_directory  � ��� o  ���J�J 0 current_directory  � ��I� o  ���H�H 0 saved_directory  �I  �S  �U  x ��� = ����� n ����� 4 ���G�
�G 
cobj� m  ���F�F � o  ���E�E 0 arg  � m  ���� ��� 
 s a v e d� ��� k  ��� ��� l ���D���D  �    $ unsplash saved [string]   � ��� 4   $   u n s p l a s h   s a v e d   [ s t r i n g ]� ��� l ���C���C  � #  $ unsplash saved TZCehSn-T-o   � ��� :   $   u n s p l a s h   s a v e d   T Z C e h S n - T - o� ��B� I  ��A��@�A .0 loadrandomsavedimages loadRandomSavedImages� ��� o   �?�? 0 arg  � ��� o  �>�> 0 
configpath 
configPath� ��� o  �=�= 0 saved_directory  � ��<� o  �;�; 0 current_directory  �<  �@  �B  � ��� = ��� n ��� 4 �:�
�: 
cobj� m  �9�9 � o  �8�8 0 arg  � m  �� ��� 
 w i d t h� ��� k  %�� ��� l �7���7  � !  $ unsplash width [integer]   � ��� 6   $   u n s p l a s h   w i d t h   [ i n t e g e r ]� ��� l �6���6  �   $ unsplash width 2560   � ��� ,   $   u n s p l a s h   w i d t h   2 5 6 0� ��5� I  %�4��3�4 .0 configuredesktopwidth configureDesktopWidth� ��� o   �2�2 0 arg  � ��1� o   !�0�0 0 
configpath 
configPath�1  �3  �5  � ��� = (2��� n (.��� 4 ).�/�
�/ 
cobj� m  ,-�.�. � o  ()�-�- 0 arg  � m  .1�� ���  h e i g h t� ��,� k  5<�� ��� l 55�+���+  � "  $ unsplash height [integer]   � ��� 8   $   u n s p l a s h   h e i g h t   [ i n t e g e r ]� ��� l 55�*���*  �   $ unsplash height 2560   � ��� .   $   u n s p l a s h   h e i g h t   2 5 6 0� ��)� I  5<�(��'�( 00 configuredesktopheight configureDesktopHeight� ��� o  67�&�& 0 arg  � ��%� o  78�$�$ 0 
configpath 
configPath�%  �'  �)  �,  ��  ��  � I  CJ�#��"�# (0 checkforbasherrors checkForBashErrors� ��� o  DE�!�! 0 arg  � �� � o  EF�� 0 
configpath 
configPath�   �"  �'    ��� l     ����  �  �  � ��� l      ����  � P J  ************************** Begin Subroutines **************************    � ��� �     * * * * * * * * * * * * * * * * * * * * * * * * * *   B e g i n   S u b r o u t i n e s   * * * * * * * * * * * * * * * * * * * * * * * * * *  � ��� l     ����  �  �  � ��� i    ��� I      ���� $0 getnetworkstatus getNetworkStatus� ��� o      �� 0 testurl testURL�  �  � L     
   I    	��
� .sysoexecTEXT���     TEXT b      b      m      � B c a s e   " $ ( c u r l   - s   - - m a x - t i m e   2   - I   ' o    �� 0 testurl testURL m     �		b '   |   s e d   ' s / ^ [ ^   ] *     * \ ( [ 0 - 9 ] \ ) . * / \ 1 / ;   1 q ' ) "   i n   [ 2 3 ] )   e c h o   " H T T P   c o n n e c t i o n   O K " ; ;   5 )   e c h o   " W e b   p r o x y   w i l l   n o t   a l l o w   c o n n e c t i o n " ; ;   * )   e c h o   " T h e   n e t w o r k   i s   d o w n   o r   v e r y   s l o w " ; ;   e s a c�  � 

 l     ����  �  �    i     I      ��� .0 refreshapicredentials refreshApiCredentials � o      �
�
 0 
configpath 
configPath�  �   k     9  l     �	�	   5 / Refresh API url from adamdehaven.com/unsplash/    � ^   R e f r e s h   A P I   u r l   f r o m   a d a m d e h a v e n . c o m / u n s p l a s h /  r     	 I    �
� .sysoexecTEXT���     TEXT m      � � u r l = $ ( c u r l   ' h t t p : / / a d a m d e h a v e n . c o m / u n s p l a s h / r e p a i r - a p i / ? a p p = W a l l p a p e r s - f r o m - U n s p l a s h & v a l u e = u r l ' )   & &   e c h o   $ u r l � �
� 
rtyp  m    �
� 
TEXT�   o      �� 0 unsplash_api_url   !"! I  
 �#�
� .sysoexecTEXT���     TEXT# b   
 $%$ b   
 &'& b   
 ()( b   
 *+* m   
 ,, �--  d e f a u l t s   w r i t e  + o    �� 0 
configpath 
configPath) m    .. �// > c o n f i g . p l i s t   u n s p l a s h _ a p i _ u r l   '' o    � �  0 unsplash_api_url  % m    00 �11  '�  " 232 l   ��45��  4 ; 5 Refresh API client_id from adamdehaven.com/unsplash/   5 �66 j   R e f r e s h   A P I   c l i e n t _ i d   f r o m   a d a m d e h a v e n . c o m / u n s p l a s h /3 787 r    !9:9 I   ��;<
�� .sysoexecTEXT���     TEXT; m    == �>> � c l i e n t i d = $ ( c u r l   ' h t t p : / / a d a m d e h a v e n . c o m / u n s p l a s h / r e p a i r - a p i / ? a p p = W a l l p a p e r s - f r o m - U n s p l a s h & v a l u e = c l i e n t _ i d ' )   & &   e c h o   $ c l i e n t i d< ��?��
�� 
rtyp? m    ��
�� 
TEXT��  : o      ���� 0 unsplash_api_client_id  8 @A@ I  " /��B��
�� .sysoexecTEXT���     TEXTB b   " +CDC b   " )EFE b   " 'GHG b   " %IJI m   " #KK �LL  d e f a u l t s   w r i t e  J o   # $���� 0 
configpath 
configPathH m   % &MM �NN J c o n f i g . p l i s t   u n s p l a s h _ a p i _ c l i e n t _ i d   'F o   ' (���� 0 unsplash_api_client_id  D m   ) *OO �PP  '��  A Q��Q I  0 9��R��
�� .sysoexecTEXT���     TEXTR b   0 5STS b   0 3UVU m   0 1WW �XX  d e f a u l t s   w r i t e  V o   1 2���� 0 
configpath 
configPathT m   3 4YY �ZZ L c o n f i g . p l i s t   u n s p l a s h _ i n i t i a l _ r u n   ' n o '��  ��   [\[ l     ��������  ��  ��  \ ]^] l     ��_`��  _   Configure desktop width   ` �aa 0   C o n f i g u r e   d e s k t o p   w i d t h^ bcb i    ded I      ��f���� .0 configuredesktopwidth configureDesktopWidthf ghg o      ���� 0 arg  h i��i o      ���� 0 
configpath 
configPath��  ��  e k     jj klk r     mnm c     opo n    qrq 4   ��s
�� 
cobjs m    ���� r o     ���� 0 arg  p m    ��
�� 
nmbrn o      ���� 0 desktopwidth desktopWidthl t��t I  	 ��u��
�� .sysoexecTEXT���     TEXTu b   	 vwv b   	 xyx b   	 z{z b   	 |}| b   	 ~~ b   	 ��� m   	 
�� ���  d e f a u l t s   w r i t e  � o   
 ���� 0 
configpath 
configPath m    �� ��� B c o n f i g . p l i s t   u s e r _ d e s k t o p _ w i d t h   '} o    ���� 0 desktopwidth desktopWidth{ m    �� ��� � '   & &   e c h o   " D e s k t o p   w i d t h   f o r   ' W a l l p a p e r s   f r o m   U n s p l a s h '   h a s   b e e n   s e t   t o  y o    ���� 0 desktopwidth desktopWidthw m    �� ���  " p x .��  ��  c ��� l     ��������  ��  ��  � ��� l     ������  �   Configure desktop height   � ��� 2   C o n f i g u r e   d e s k t o p   h e i g h t� ��� i    ��� I      ������� 00 configuredesktopheight configureDesktopHeight� ��� o      ���� 0 arg  � ���� o      ���� 0 
configpath 
configPath��  ��  � k     �� ��� r     ��� c     ��� n    ��� 4   ���
�� 
cobj� m    ���� � o     ���� 0 arg  � m    ��
�� 
nmbr� o      ���� 0 desktopheight desktopHeight� ���� I  	 �����
�� .sysoexecTEXT���     TEXT� b   	 ��� b   	 ��� b   	 ��� b   	 ��� b   	 ��� b   	 ��� m   	 
�� ���  d e f a u l t s   w r i t e  � o   
 ���� 0 
configpath 
configPath� m    �� ��� D c o n f i g . p l i s t   u s e r _ d e s k t o p _ h e i g h t   '� o    ���� 0 desktopheight desktopHeight� m    �� ��� � '   & &   e c h o   " D e s k t o p   h e i g h t   f o r   ' W a l l p a p e r s   f r o m   U n s p l a s h '   h a s   b e e n   s e t   t o  � o    ���� 0 desktopheight desktopHeight� m    �� ���  " p x .��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � * $ RANDOM WALLPAPER FOR ALL DESKTOP(S)   � ��� H   R A N D O M   W A L L P A P E R   F O R   A L L   D E S K T O P ( S )� ��� l     ������  �   Includes:	Random   � ��� "   I n c l u d e s : 	 R a n d o m� ��� l     ������  �  			Random from featured   � ��� . 	 	 	 R a n d o m   f r o m   f e a t u r e d� ��� l     ������  �  			Random from search   � ��� * 	 	 	 R a n d o m   f r o m   s e a r c h� ��� l     ������  �  			Random from username   � ��� . 	 	 	 R a n d o m   f r o m   u s e r n a m e� ��� l     ������  � P J			Random from collection (Does not currently support curated collections)   � ��� � 	 	 	 R a n d o m   f r o m   c o l l e c t i o n   ( D o e s   n o t   c u r r e n t l y   s u p p o r t   c u r a t e d   c o l l e c t i o n s )� ��� i    ��� I      ������� &0 fetchrandomimages fetchRandomImages� ��� o      ���� 0 arg  � ��� o      ���� 0 
configpath 
configPath� ��� o      ���� 0 unsplash_api_url  � ��� o      ���� 0 unsplash_api_client_id  � ��� o      ���� 0 user_project_path  � ��� o      ���� 0 user_desktop_width  � ��� o      ���� 0 user_desktop_height  � ��� o      ���� 0 images_directory  � ���� o      ���� 0 current_directory  ��  ��  � k    {�� ��� Z     ~������ ?    ��� l    ������ I    �����
�� .corecnte****       ****� o     ���� 0 arg  ��  ��  ��  � m    ����  � Z   
 v������ =  
 ��� n  
 ��� 4   �� 
�� 
cobj  m    ���� � o   
 ���� 0 arg  � m     �  f e a t u r e d� k      l   ����     Create featured string    � .   C r e a t e   f e a t u r e d   s t r i n g 	
	 r     c     m     �   m    ��
�� 
TEXT o      ���� 0 	userinput 	userInput
 �� r     c     m     �  & f e a t u r e d = y e s m    ��
�� 
TEXT o      ���� 0 	userquery 	userQuery��  �  =  ! ' n  ! % 4  " %��
�� 
cobj m   # $����  o   ! "���� 0 arg   m   % & �    s e a r c h !"! k   * :## $%$ l  * *��&'��  & !  Create search query string   ' �(( 6   C r e a t e   s e a r c h   q u e r y   s t r i n g% )*) r   * 2+,+ c   * 0-.- n  * ./0/ 4  + .��1
�� 
cobj1 m   , -���� 0 o   * +���� 0 arg  . m   . /��
�� 
TEXT, o      ���� 0 	userinput 	userInput* 2��2 r   3 :343 c   3 8565 b   3 6787 m   3 499 �::  & q u e r y =8 o   4 5���� 0 	userinput 	userInput6 m   6 7��
�� 
TEXT4 o      ���� 0 	userquery 	userQuery��  " ;<; =  = C=>= n  = A?@? 4  > A��A
�� 
cobjA m   ? @���� @ o   = >���� 0 arg  > m   A BBB �CC  u s e r n a m e< DED k   F VFF GHG l  F F��IJ��  I #  Create username query string   J �KK :   C r e a t e   u s e r n a m e   q u e r y   s t r i n gH LML r   F NNON c   F LPQP n  F JRSR 4  G J��T
�� 
cobjT m   H I���� S o   F G���� 0 arg  Q m   J K��
�� 
TEXTO o      ���� 0 	userinput 	userInputM U��U r   O VVWV c   O TXYX b   O RZ[Z m   O P\\ �]]  & u s e r n a m e =[ o   P Q���� 0 	userinput 	userInputY m   R S��
�� 
TEXTW o      ���� 0 	userquery 	userQuery��  E ^_^ =  Y _`a` n  Y ]bcb 4  Z ]��d
�� 
cobjd m   [ \���� c o   Y Z���� 0 arg  a m   ] ^ee �ff  c o l l e c t i o n_ g��g k   b rhh iji l  b b��kl��  k "  Create collection id string   l �mm 8   C r e a t e   c o l l e c t i o n   i d   s t r i n gj non r   b jpqp c   b hrsr n  b ftut 4  c f��v
�� 
cobjv m   d e���� u o   b c���� 0 arg  s m   f g��
�� 
TEXTq o      ���� 0 	userinput 	userInputo w�w r   k rxyx c   k pz{z b   k n|}| m   k l~~ �  & c o l l e c t i o n s =} o   l m�~�~ 0 	userinput 	userInput{ m   n o�}
�} 
TEXTy o      �|�| 0 	userquery 	userQuery�  ��  ��  ��  � r   y ~��� c   y |��� m   y z�� ���  � m   z {�{
�{ 
TEXT� o      �z�z 0 	userquery 	userQuery� ��y� O   {��� k   �z�� ��� r   � ���� I  � ��x��w
�x .corecnte****       ****� 2  � ��v
�v 
dskp�w  � o      �u�u 0 desktopcount desktopCount� ��� l  � ��t���t  � 5 / Add all current wallpapers to currentPhotoList   � ��� ^   A d d   a l l   c u r r e n t   w a l l p a p e r s   t o   c u r r e n t P h o t o L i s t� ��� r   � ���� J   � ��s�s  � o      �r�r $0 currentphotolist currentPhotoList� ��� Y   � ���q���p� O   � ���� k   � ��� ��� l  � ��o���o  � / ) Get name of current photo (for deletion)   � ��� R   G e t   n a m e   o f   c u r r e n t   p h o t o   ( f o r   d e l e t i o n )� ��� r   � ���� e   � ��� c   � ���� 1   � ��n
�n 
picP� m   � ��m
�m 
TEXT� o      �l�l &0 previouswallpaper previousWallpaper� ��k� s   � ���� o   � ��j�j &0 previouswallpaper previousWallpaper� n      ���  ;   � �� o   � ��i�i $0 currentphotolist currentPhotoList�k  � 4   � ��h�
�h 
dskp� o   � ��g�g 0 desktopnumber desktopNumber�q 0 desktopnumber desktopNumber� m   � ��f�f � o   � ��e�e 0 desktopcount desktopCount�p  � ��� l  � ��d���d  � @ : empty current_wallpapers directory to prevent stale files   � ��� t   e m p t y   c u r r e n t _ w a l l p a p e r s   d i r e c t o r y   t o   p r e v e n t   s t a l e   f i l e s� ��� I  � ��c��b
�c .sysoexecTEXT���     TEXT� b   � ���� b   � ���� m   � ��� ���  r m   - r   - f  � o   � ��a�a 0 current_directory  � m   � ��� ���  *�b  � ��� Y   �#��`���_� O   ���� k   ��� ��� l  � ��^���^  �   Set URL for curl   � ��� "   S e t   U R L   f o r   c u r l� ��� r   � ���� c   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� o   � ��]�] 0 unsplash_api_url  � m   � ��� ��� 0 p h o t o s / r a n d o m ? c l i e n t _ i d =� o   � ��\�\ 0 unsplash_api_client_id  � o   � ��[�[ 0 	userquery 	userQuery� m   � ��� ���  & w =� o   � ��Z�Z 0 user_desktop_width  � m   � ��� ���  & h =� o   � ��Y�Y 0 user_desktop_height  � m   � ��X
�X 
TEXT� o      �W�W 0 fetchurl fetchUrl� ��� l  � ��V���V  � ) # Check if URL is valid (status 200)   � ��� F   C h e c k   i f   U R L   i s   v a l i d   ( s t a t u s   2 0 0 )� ��� r   ���� I  � �U��
�U .sysoexecTEXT���     TEXT� b   � ���� b   � ���� m   � ��� ��� � h t t p R e s p o n s e = $ ( c u r l   - - w r i t e - o u t   " % { h t t p _ c o d e } "   - - s i l e n t   - - o u t p u t   / d e v / n u l l   "� o   � ��T�T 0 fetchurl fetchUrl� m   � ��� ��� P " )   & &   e c h o   " $ h t t p R e s p o n s e "   | |   e c h o   " 5 0 0 "� �S��R
�S 
rtyp� m   � ��Q
�Q 
TEXT�R  � o      �P�P 0 httpcode httpCode� ��O� Z  �� � =  o  �N�N 0 httpcode httpCode m   �  2 0 0� k  B  l �M	
�M  	   Display loading image   
 � ,   D i s p l a y   l o a d i n g   i m a g e  r   b   o  �L�L 0 images_directory   m   � ( u n s p l a s h _ l o a d i n g . j p g 1  �K
�K 
picP  l �J�J     Fetch new images    � "   F e t c h   n e w   i m a g e s  r  4 I 0�I
�I .sysoexecTEXT���     TEXT b  (  b  $!"! b  "#$# b  %&% m  '' �(( " r e s p o n s e = $ ( c u r l   '& o  �H�H 0 fetchurl fetchUrl$ m  !)) �**2 ' )   & &   p h o t o I d = ` e c h o   $ r e s p o n s e   |   s e d   - e   ' s / ^ { " i d " : " / / '   - e   ' s / " . * / / ' `   & &   p h o t o U r l = ` e c h o   $ r e s p o n s e   |   s e d   - e   ' s / ^ . * " c u s t o m " : " / / '   - e   ' s / " . * / / ' `   & &   c u r l   - L   - o  " o  "#�G�G 0 current_directory    m  $'++ �,, Z " $ p h o t o I d " . j p g   " $ p h o t o U r l "   & &   e c h o   " $ p h o t o I d " �F-�E
�F 
rtyp- m  +,�D
�D 
TEXT�E   o      �C�C "0 photoidentifier photoIdentifier ./. l 55�B01�B  0   Set desktop wallpaper   1 �22 ,   S e t   d e s k t o p   w a l l p a p e r/ 3�A3 r  5B454 b  5>676 b  5:898 o  56�@�@ 0 current_directory  9 o  69�?�? "0 photoidentifier photoIdentifier7 m  :=:: �;;  . j p g5 1  >A�>
�> 
picP�A    <=< F  Ei>?> F  EZ@A@ = ELBCB o  EH�=�= 0 httpcode httpCodeC m  HKDD �EE  4 0 4A ? OVFGF l OTH�<�;H I OT�:I�9
�: .corecnte****       ****I o  OP�8�8 0 arg  �9  �<  �;  G m  TU�7�7  ? = ]eJKJ n ]aLML 4 ^a�6N
�6 
cobjN m  _`�5�5 M o  ]^�4�4 0 arg  K m  adOO �PP  s e a r c h= QRQ k  lvSS TUT l ll�3VW�3  V ' ! No images matched search term(s)   W �XX B   N o   i m a g e s   m a t c h e d   s e a r c h   t e r m ( s )U Y�2Y L  lvZZ b  lu[\[ b  lq]^] m  lo__ �`` n # 	 
 # 	 N o   i m a g e s   w e r e   f o u n d   m a t c h i n g   y o u r   s e a r c h   
 # 	 f o r   '^ o  op�1�1 0 	userinput 	userInput\ m  qtaa �bb 
 ' . 
 # 	�2  R cdc F  y�efe F  y�ghg = y�iji o  y|�0�0 0 httpcode httpCodej m  |kk �ll  4 0 4h ? ��mnm l ��o�/�.o I ���-p�,
�- .corecnte****       ****p o  ���+�+ 0 arg  �,  �/  �.  n m  ���*�*  f = ��qrq n ��sts 4 ���)u
�) 
cobju m  ���(�( t o  ���'�' 0 arg  r m  ��vv �ww  u s e r n a m ed xyx k  ��zz {|{ l ���&}~�&  } + % No user with that username was found   ~ � J   N o   u s e r   w i t h   t h a t   u s e r n a m e   w a s   f o u n d| ��%� L  ���� b  ����� b  ����� m  ���� ��� , # 	 
 # 	 S o r r y ,   u s e r n a m e   '� o  ���$�$ 0 	userinput 	userInput� m  ���� ��� 0 '   c o u l d   n o t   b e   f o u n d . 
 # 	�%  y ��� F  ����� F  ����� = ����� o  ���#�# 0 httpcode httpCode� m  ���� ���  4 0 4� ? ����� l ����"�!� I ��� ��
�  .corecnte****       ****� o  ���� 0 arg  �  �"  �!  � m  ����  � = ����� n ����� 4 ����
� 
cobj� m  ���� � o  ���� 0 arg  � m  ���� ���  c o l l e c t i o n� ��� k  ���� ��� l ������  � + % No collection with that id was found   � ��� J   N o   c o l l e c t i o n   w i t h   t h a t   i d   w a s   f o u n d� ��� L  ���� b  ����� b  ����� m  ���� ��� L # 	 
 # 	 S o r r y ,   n o   p h o t o s   f o r   c o l l e c t i o n   '� o  ���� 0 	userinput 	userInput� m  ���� ��� � '   c o u l d   b e   f o u n d .   
 # 	 P l e a s e   c h e c k   t h e   c o l l e c t i o n   I D   a n d   t r y   a g a i n . 
 # 	�  �   Z  ������ F  ����� ? ����� l ������ I �����
� .corecnte****       ****� o  ���� 0 arg  �  �  �  � m  ����  � = ����� n ����� 4 ����
� 
cobj� m  ���� � o  ���� 0 arg  � m  ���� ���  c o l l e c t i o n� k  ��� ��� l ������  � J D Try to repair API credentials. REMOVE NEXT LINE FOR ALFRED WORKFLOW   � ��� �   T r y   t o   r e p a i r   A P I   c r e d e n t i a l s .   R E M O V E   N E X T   L I N E   F O R   A L F R E D   W O R K F L O W� ��� n � ��� I  � �
��	�
 .0 refreshapicredentials refreshApiCredentials� ��� o  ���� 0 
configpath 
configPath�  �	  �  f  ��� ��� l ����  � + % No collection with that id was found   � ��� J   N o   c o l l e c t i o n   w i t h   t h a t   i d   w a s   f o u n d� ��� L  �� b  
��� b  ��� m  �� ��� L # 	 
 # 	 S o r r y ,   n o   p h o t o s   f o r   c o l l e c t i o n   '� o  �� 0 	userinput 	userInput� m  	�� ��� � '   c o u l d   b e   f o u n d .   
 # 	 P l e a s e   c h e c k   t h e   c o l l e c t i o n   I D   a n d   t r y   a g a i n . 
 # 	�  �  � k  �� ��� l ����  � J D Try to repair API credentials. REMOVE NEXT LINE FOR ALFRED WORKFLOW   � ��� �   T r y   t o   r e p a i r   A P I   c r e d e n t i a l s .   R E M O V E   N E X T   L I N E   F O R   A L F R E D   W O R K F L O W� ��� n ��� I  ���� .0 refreshapicredentials refreshApiCredentials� �� � o  ���� 0 
configpath 
configPath�   �  �  f  � ���� L  �� b  ��� m  �� ��� # 	 
 # 	 T h e r e   w a s   a   p r o b l e m   c o n n e c t i n g   t o   t h e   U n s p l a s h   A P I .   
 # 	 P l e a s e   w a i t   a   m o m e n t   a n d   t r y   y o u r   r e q u e s t   a g a i n .   
 # 	 
 # 	 I f   t h e   p r o b l e m   p e r s i s t s ,   p l e a s e   c h e c k   t h e   p r o j e c t   
 # 	 d o c u m e n t a t i o n   a t   h t t p s : / / g i t h u b . c o m / a d a m d e h a v e n / W a l l p a p e r s - f r o m - U n s p l a s h 
 # 	 
 # 	 S t a t u s   C o d e :  � o  ���� 0 httpcode httpCode��  �O  � 4   � ����
�� 
dskp� o   � ����� 0 desktopnumber desktopNumber�` 0 desktopnumber desktopNumber� m   � ����� � o   � ����� 0 desktopcount desktopCount�_  � ��� l $$������  � ~ x If any photo in currentPhotoList is not loading image or saved confirmation or Apple's default desktop image, delete it   � ��� �   I f   a n y   p h o t o   i n   c u r r e n t P h o t o L i s t   i s   n o t   l o a d i n g   i m a g e   o r   s a v e d   c o n f i r m a t i o n   o r   A p p l e ' s   d e f a u l t   d e s k t o p   i m a g e ,   d e l e t e   i t� ���� X  $z����� k  6u�� ��� r  6?��� c  6;��� o  69���� 0 	photoitem 	photoItem� m  9:��
�� 
TEXT� o      ���� 0 thephoto thePhoto� ���� Z  @u���� � G  @c G  @U E @G o  @C���� 0 thephoto thePhoto m  CF �   u n s p l a s h _ l o a d i n g E JQ	
	 o  JM���� 0 thephoto thePhoto
 m  MP �  u n s p l a s h _ s a v e d E X_ o  X[���� 0 thephoto thePhoto m  [^ �  D e f a u l t D e s k t o p� l ff����     Do nothing    �    D o   n o t h i n g��    I ju����
�� .sysoexecTEXT���     TEXT b  jq m  jm �  r m   - r   - f   o  mp���� 0 thephoto thePhoto��  ��  �� 0 	photoitem 	photoItem� o  '(���� $0 currentphotolist currentPhotoList��  � m    ��                                                                                  sevs  alis    �  Macintosh HD               ���H+  �T�System Events.app                                              �f�����        ����  	                CoreServices    ��*�      ����    �T��T��T  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �y  �  l     ��������  ��  ��    l     ����   2 , FETCH SPECIFIC WALLPAPER FOR ALL DESKTOP(S)    �   X   F E T C H   S P E C I F I C   W A L L P A P E R   F O R   A L L   D E S K T O P ( S ) !"! i    #$# I      ��%���� (0 fetchspecificimage fetchSpecificImage% &'& o      ���� 0 arg  ' ()( o      ���� 0 
configpath 
configPath) *+* o      ���� 0 unsplash_api_url  + ,-, o      ���� 0 unsplash_api_client_id  - ./. o      ���� 0 user_project_path  / 010 o      ���� 0 user_desktop_width  1 232 o      ���� 0 user_desktop_height  3 454 o      ���� 0 images_directory  5 6��6 o      ���� 0 current_directory  ��  ��  $ O    ;787 k   :99 :;: r    <=< c    
>?> n   @A@ 4   ��B
�� 
cobjB m    ���� A o    ���� 0 arg  ? m    	��
�� 
TEXT= o      ���� 0 imagetofetch imageToFetch; CDC r    EFE I   ��G��
�� .corecnte****       ****G 2   ��
�� 
dskp��  F o      ���� 0 desktopcount desktopCountD HIH l   ��JK��  J 5 / Add all current wallpapers to currentPhotoList   K �LL ^   A d d   a l l   c u r r e n t   w a l l p a p e r s   t o   c u r r e n t P h o t o L i s tI MNM r    OPO J    ����  P o      ���� $0 currentphotolist currentPhotoListN QRQ Y    ?S��TU��S O   & :VWV k   - 9XX YZY l  - -��[\��  [ / ) Get name of current photo (for deletion)   \ �]] R   G e t   n a m e   o f   c u r r e n t   p h o t o   ( f o r   d e l e t i o n )Z ^_^ r   - 4`a` e   - 2bb c   - 2cdc 1   - 0��
�� 
picPd m   0 1��
�� 
TEXTa o      ���� &0 previouswallpaper previousWallpaper_ e��e s   5 9fgf o   5 6���� &0 previouswallpaper previousWallpaperg n      hih  ;   7 8i o   6 7���� $0 currentphotolist currentPhotoList��  W 4   & *��j
�� 
dskpj o   ( )���� 0 desktopnumber desktopNumber�� 0 desktopnumber desktopNumberT m     ���� U o     !���� 0 desktopcount desktopCount��  R klk l  @ @��mn��  m @ : empty current_wallpapers directory to prevent stale files   n �oo t   e m p t y   c u r r e n t _ w a l l p a p e r s   d i r e c t o r y   t o   p r e v e n t   s t a l e   f i l e sl pqp I  @ I��r��
�� .sysoexecTEXT���     TEXTr b   @ Ests b   @ Cuvu m   @ Aww �xx  r m   - r   - f  v o   A B���� 0 current_directory  t m   C Dyy �zz  *��  q {|{ Y   J �}��~��} O   T ���� k   [ ��� ��� l  [ [������  �   Set URL for curl   � ��� "   S e t   U R L   f o r   c u r l� ��� r   [ p��� c   [ n��� b   [ l��� b   [ j��� b   [ h��� b   [ f��� b   [ d��� b   [ b��� b   [ `��� b   [ ^��� o   [ \���� 0 unsplash_api_url  � m   \ ]�� ���  p h o t o s /� o   ^ _���� 0 imagetofetch imageToFetch� m   ` a�� ���  / ? c l i e n t _ i d =� o   b c���� 0 unsplash_api_client_id  � m   d e�� ���  & w =� o   f g���� 0 user_desktop_width  � m   h i�� ���  & h =� o   j k���� 0 user_desktop_height  � m   l m��
�� 
TEXT� o      ���� 0 fetchurl fetchUrl� ��� l  q q������  � ) # Check if URL is valid (status 200)   � ��� F   C h e c k   i f   U R L   i s   v a l i d   ( s t a t u s   2 0 0 )� ��� r   q ~��� I  q |����
�� .sysoexecTEXT���     TEXT� b   q v��� b   q t��� m   q r�� ��� � h t t p R e s p o n s e = $ ( c u r l   - - w r i t e - o u t   " % { h t t p _ c o d e } "   - - s i l e n t   - - o u t p u t   / d e v / n u l l   "� o   r s���� 0 fetchurl fetchUrl� m   t u�� ��� P " )   & &   e c h o   " $ h t t p R e s p o n s e "   | |   e c h o   " 5 0 0 "� �����
�� 
rtyp� m   w x��
�� 
TEXT��  � o      ���� 0 httpcode httpCode� ���� Z    ������ =   ���� o    ����� 0 httpcode httpCode� m   � ��� ���  2 0 0� k   � ��� ��� l  � �������  �   Display loading image   � ��� ,   D i s p l a y   l o a d i n g   i m a g e� ��� r   � ���� b   � ���� o   � ����� 0 images_directory  � m   � ��� ��� ( u n s p l a s h _ l o a d i n g . j p g� 1   � ���
�� 
picP� ��� l  � �������  �   Fetch new image   � ���     F e t c h   n e w   i m a g e� ��� r   � ���� I  � �����
�� .sysoexecTEXT���     TEXT� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� " r e s p o n s e = $ ( c u r l   '� o   � ����� 0 fetchurl fetchUrl� m   � ��� ���2 ' )   & &   p h o t o I d = ` e c h o   $ r e s p o n s e   |   s e d   - e   ' s / ^ { " i d " : " / / '   - e   ' s / " . * / / ' `   & &   p h o t o U r l = ` e c h o   $ r e s p o n s e   |   s e d   - e   ' s / ^ . * " c u s t o m " : " / / '   - e   ' s / " . * / / ' `   & &   c u r l   - L   - o  � o   � ����� 0 current_directory  � m   � ��� ��� Z " $ p h o t o I d " . j p g   " $ p h o t o U r l "   & &   e c h o   " $ p h o t o I d "� �����
�� 
rtyp� m   � ���
�� 
TEXT��  � o      ���� "0 photoidentifier photoIdentifier� ��� l  � �������  �   Set desktop wallpaper   � ��� ,   S e t   d e s k t o p   w a l l p a p e r� ���� r   � ���� b   � ���� b   � ���� o   � ����� 0 current_directory  � o   � ����� "0 photoidentifier photoIdentifier� m   � ��� ���  . j p g� 1   � ���
�� 
picP��  � ��� =  � ���� o   � ����� 0 httpcode httpCode� m   � ��� ���  4 0 4� ���� L   � �   b   � � b   � � m   � � � l # 	 
 # 	 S o r r y ,   t h a t   i m a g e   I D   c o u l d   n o t   b e   f o u n d .   S t a t u s :   o   � ����� 0 httpcode httpCode m   � � �  
 # 	��  � k   � �		 

 l  � �����   J D Try to repair API credentials. REMOVE NEXT LINE FOR ALFRED WORKFLOW    � �   T r y   t o   r e p a i r   A P I   c r e d e n t i a l s .   R E M O V E   N E X T   L I N E   F O R   A L F R E D   W O R K F L O W  n  � � I   � ������� .0 refreshapicredentials refreshApiCredentials �� o   � ����� 0 
configpath 
configPath��  ��    f   � � �� L   � � b   � � m   � � � # 	 
 # 	 T h e r e   w a s   a   p r o b l e m   c o n n e c t i n g   t o   t h e   U n s p l a s h   A P I .   
 # 	 P l e a s e   w a i t   a   m o m e n t   a n d   t r y   y o u r   r e q u e s t   a g a i n .   
 # 	 
 # 	 I f   t h e   p r o b l e m   p e r s i s t s ,   p l e a s e   c h e c k   t h e   p r o j e c t   
 # 	 d o c u m e n t a t i o n   a t   h t t p s : / / g i t h u b . c o m / a d a m d e h a v e n / W a l l p a p e r s - f r o m - U n s p l a s h 
 # 	 
 # 	 S t a t u s   C o d e :   o   � ����� 0 httpcode httpCode��  ��  � 4   T X��
�� 
dskp o   V W���� 0 desktopnumber desktopNumber�� 0 desktopnumber desktopNumber~ m   M N����  o   N O���� 0 desktopcount desktopCount��  |  l  � �����   ~ x If any photo in currentPhotoList is not loading image or saved confirmation or Apple's default desktop image, delete it    �   �   I f   a n y   p h o t o   i n   c u r r e n t P h o t o L i s t   i s   n o t   l o a d i n g   i m a g e   o r   s a v e d   c o n f i r m a t i o n   o r   A p p l e ' s   d e f a u l t   d e s k t o p   i m a g e ,   d e l e t e   i t !��! X   �:"��#" k   �5$$ %&% r   � �'(' c   � �)*) o   � ����� 0 	photoitem 	photoItem* m   � ���
�� 
TEXT( o      ���� 0 thephoto thePhoto& +��+ Z   5,-��., G   #/0/ G   121 E  343 o   ���� 0 thephoto thePhoto4 m  55 �66   u n s p l a s h _ l o a d i n g2 E 
787 o  
���� 0 thephoto thePhoto8 m  99 �::  u n s p l a s h _ s a v e d0 E ;<; o  ���� 0 thephoto thePhoto< m  == �>>  D e f a u l t D e s k t o p- l &&�?@�  ?   Do nothing   @ �AA    D o   n o t h i n g��  . I *5�~B�}
�~ .sysoexecTEXT���     TEXTB b  *1CDC m  *-EE �FF  r m   - r   - f  D o  -0�|�| 0 thephoto thePhoto�}  ��  �� 0 	photoitem 	photoItem# o   � ��{�{ $0 currentphotolist currentPhotoList��  8 m     GG�                                                                                  sevs  alis    �  Macintosh HD               ���H+  �T�System Events.app                                              �f�����        ����  	                CoreServices    ��*�      ����    �T��T��T  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  " HIH l     �z�y�x�z  �y  �x  I JKJ l     �wLM�w  L * $ RANDOM WALLPAPER FOR DESKTOP NUMBER   M �NN H   R A N D O M   W A L L P A P E R   F O R   D E S K T O P   N U M B E RK OPO i    QRQ I      �vS�u�v 80 fetchrandomimagefordesktop fetchRandomImageForDesktopS TUT o      �t�t 0 arg  U VWV o      �s�s 0 
configpath 
configPathW XYX o      �r�r 0 unsplash_api_url  Y Z[Z o      �q�q 0 unsplash_api_client_id  [ \]\ o      �p�p 0 user_project_path  ] ^_^ o      �o�o 0 user_desktop_width  _ `a` o      �n�n 0 user_desktop_height  a bcb o      �m�m 0 images_directory  c d�ld o      �k�k 0 current_directory  �l  �u  R O    Kefe k   Jgg hih r    jkj c    
lml n   non 4   �jp
�j 
cobjp m    �i�i o o    �h�h 0 arg  m m    	�g
�g 
nmbrk o      �f�f 0 desktopnumber desktopNumberi qrq r    sts I   �eu�d
�e .corecnte****       ****u 2   �c
�c 
dskp�d  t o      �b�b 0 desktopcount desktopCountr vwv Z    Mxyz�ax G    *{|{ =   }~} o    �`�` 0 desktopnumber desktopNumber~ m    �_�_  | l   (�^�] F    (��� ?    ��� o    �\�\ 0 desktopnumber desktopNumber� o    �[�[ 0 desktopcount desktopCount� =  # &��� o   # $�Z�Z 0 desktopcount desktopCount� m   $ %�Y�Y �^  �]  y r   - 2��� c   - 0��� m   - .�X�X � m   . /�W
�W 
nmbr� o      �V�V 0 desktopnumber desktopNumberz ��� F   5 @��� ?  5 8��� o   5 6�U�U 0 desktopnumber desktopNumber� o   6 7�T�T 0 desktopcount desktopCount� ?  ; >��� o   ; <�S�S 0 desktopcount desktopCount� m   < =�R�R � ��Q� L   C I�� b   C H��� b   C F��� m   C D�� ��� f # 	 
 # 	 P l e a s e   s p e c i f y   a   d e s k t o p   n u m b e r   b e t w e e n   1   a n d  � o   D E�P�P 0 desktopcount desktopCount� m   F G�� ���  . 
 # 	�Q  �a  w ��� l  N N�O���O  � 5 / Add all current wallpapers to currentPhotoList   � ��� ^   A d d   a l l   c u r r e n t   w a l l p a p e r s   t o   c u r r e n t P h o t o L i s t� ��� r   N R��� J   N P�N�N  � o      �M�M $0 currentphotolist currentPhotoList� ��L� O   SJ��� k   ZI�� ��� l  Z Z�K���K  � / ) Get name of current photo (for deletion)   � ��� R   G e t   n a m e   o f   c u r r e n t   p h o t o   ( f o r   d e l e t i o n )� ��� r   Z a��� e   Z _�� c   Z _��� 1   Z ]�J
�J 
picP� m   ] ^�I
�I 
TEXT� o      �H�H &0 previouswallpaper previousWallpaper� ��� s   b f��� o   b c�G�G &0 previouswallpaper previousWallpaper� n      ���  ;   d e� o   c d�F�F $0 currentphotolist currentPhotoList� ��� l  g g�E���E  � D > If image is loading image or saved confirmation, don't delete   � ��� |   I f   i m a g e   i s   l o a d i n g   i m a g e   o r   s a v e d   c o n f i r m a t i o n ,   d o n ' t   d e l e t e� ��� Z   g ����D�� G   g r��� E  g j��� o   g h�C�C &0 previouswallpaper previousWallpaper� m   h i�� ���   u n s p l a s h _ l o a d i n g� E  m p��� o   m n�B�B &0 previouswallpaper previousWallpaper� m   n o�� ���  u n s p l a s h _ s a v e d� r   u x��� m   u v�� ���  � o      �A�A 0 deletephoto deletePhoto�D  � r   { ���� c   { ���� b   { ~��� m   { |�� ���     & &   c d   & &   r m   - f  � o   | }�@�@ &0 previouswallpaper previousWallpaper� m   ~ �?
�? 
TEXT� o      �>�> 0 deletephoto deletePhoto� ��� l  � ��=���=  �   Set URL for curl   � ��� "   S e t   U R L   f o r   c u r l� ��� r   � ���� c   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� o   � ��<�< 0 unsplash_api_url  � m   � ��� ��� 0 p h o t o s / r a n d o m ? c l i e n t _ i d =� o   � ��;�; 0 unsplash_api_client_id  � m   � ��� ���  & w =� o   � ��:�: 0 user_desktop_width  � m   � ��� ���  & h =� o   � ��9�9 0 user_desktop_height  � m   � ��8
�8 
TEXT� o      �7�7 0 fetchurl fetchUrl� ��� l  � ��6���6  � ) # Check if URL is valid (status 200)   � ��� F   C h e c k   i f   U R L   i s   v a l i d   ( s t a t u s   2 0 0 )� ��� r   � ��	 � I  � ��5		
�5 .sysoexecTEXT���     TEXT	 b   � �			 b   � �			 m   � �		 �		 � h t t p R e s p o n s e = $ ( c u r l   - - w r i t e - o u t   " % { h t t p _ c o d e } "   - - s i l e n t   - - o u t p u t   / d e v / n u l l   "	 o   � ��4�4 0 fetchurl fetchUrl	 m   � �				 �	
	
 P " )   & &   e c h o   " $ h t t p R e s p o n s e "   | |   e c h o   " 5 0 0 "	 �3	�2
�3 
rtyp	 m   � ��1
�1 
TEXT�2  	  o      �0�0 0 httpcode httpCode� 			 Z   � �		�/		 =  � �			 o   � ��.�. 0 httpcode httpCode	 m   � �		 �		  2 0 0	 k   � �		 			 l  � ��-		�-  	   Display loading image   	 �		 ,   D i s p l a y   l o a d i n g   i m a g e	 			 r   � �			 b   � �		 	 o   � ��,�, 0 images_directory  	  m   � �	!	! �	"	" ( u n s p l a s h _ l o a d i n g . j p g	 1   � ��+
�+ 
picP	 	#	$	# l  � ��*	%	&�*  	%   Fetch new image   	& �	'	'     F e t c h   n e w   i m a g e	$ 	(	)	( r   � �	*	+	* I  � ��)	,	-
�) .sysoexecTEXT���     TEXT	, b   � �	.	/	. b   � �	0	1	0 b   � �	2	3	2 b   � �	4	5	4 m   � �	6	6 �	7	7 " r e s p o n s e = $ ( c u r l   '	5 o   � ��(�( 0 fetchurl fetchUrl	3 m   � �	8	8 �	9	92 ' )   & &   p h o t o I d = ` e c h o   $ r e s p o n s e   |   s e d   - e   ' s / ^ { " i d " : " / / '   - e   ' s / " . * / / ' `   & &   p h o t o U r l = ` e c h o   $ r e s p o n s e   |   s e d   - e   ' s / ^ . * " c u s t o m " : " / / '   - e   ' s / " . * / / ' `   & &   c u r l   - L   - o  	1 o   � ��'�' 0 current_directory  	/ m   � �	:	: �	;	; Z " $ p h o t o I d " . j p g   " $ p h o t o U r l "   & &   e c h o   " $ p h o t o I d "	- �&	<�%
�& 
rtyp	< m   � ��$
�$ 
TEXT�%  	+ o      �#�# "0 photoidentifier photoIdentifier	) 	=	>	= l  � ��"	?	@�"  	?   Set desktop wallpaper   	@ �	A	A ,   S e t   d e s k t o p   w a l l p a p e r	> 	B�!	B r   � �	C	D	C b   � �	E	F	E b   � �	G	H	G o   � �� �  0 current_directory  	H o   � ��� "0 photoidentifier photoIdentifier	F m   � �	I	I �	J	J  . j p g	D 1   � ��
� 
picP�!  �/  	 k   � �	K	K 	L	M	L l  � ��	N	O�  	N J D Try to repair API credentials. REMOVE NEXT LINE FOR ALFRED WORKFLOW   	O �	P	P �   T r y   t o   r e p a i r   A P I   c r e d e n t i a l s .   R E M O V E   N E X T   L I N E   F O R   A L F R E D   W O R K F L O W	M 	Q	R	Q n  � �	S	T	S I   � ��	U�� .0 refreshapicredentials refreshApiCredentials	U 	V�	V o   � ��� 0 
configpath 
configPath�  �  	T  f   � �	R 	W�	W L   � �	X	X b   � �	Y	Z	Y m   � �	[	[ �	\	\ # 	 
 # 	 T h e r e   w a s   a   p r o b l e m   c o n n e c t i n g   t o   t h e   U n s p l a s h   A P I .   
 # 	 P l e a s e   w a i t   a   m o m e n t   a n d   t r y   y o u r   r e q u e s t   a g a i n .   
 # 	 
 # 	 I f   t h e   p r o b l e m   p e r s i s t s ,   p l e a s e   c h e c k   t h e   p r o j e c t   
 # 	 d o c u m e n t a t i o n   a t   h t t p s : / / g i t h u b . c o m / a d a m d e h a v e n / W a l l p a p e r s - f r o m - U n s p l a s h 
 # 	 
 # 	 S t a t u s   C o d e :  	Z o   � ��� 0 httpcode httpCode�  	 	]	^	] l  � ��	_	`�  	_ ~ x If any photo in currentPhotoList is not loading image or saved confirmation or Apple's default desktop image, delete it   	` �	a	a �   I f   a n y   p h o t o   i n   c u r r e n t P h o t o L i s t   i s   n o t   l o a d i n g   i m a g e   o r   s a v e d   c o n f i r m a t i o n   o r   A p p l e ' s   d e f a u l t   d e s k t o p   i m a g e ,   d e l e t e   i t	^ 	b�	b X   �I	c�	d	c k  	D	e	e 	f	g	f r  		h	i	h c  		j	k	j o  	�� 0 	photoitem 	photoItem	k m  �
� 
TEXT	i o      �� 0 thephoto thePhoto	g 	l�	l Z  D	m	n�	o	m G  2	p	q	p G  &	r	s	r E 	t	u	t o  �� 0 thephoto thePhoto	u m  	v	v �	w	w   u n s p l a s h _ l o a d i n g	s E $	x	y	x o   �� 0 thephoto thePhoto	y m   #	z	z �	{	{  u n s p l a s h _ s a v e d	q E )0	|	}	| o  ),�� 0 thephoto thePhoto	} m  ,/	~	~ �		  D e f a u l t D e s k t o p	n l 55�	�	��  	�   Do nothing   	� �	�	�    D o   n o t h i n g�  	o I 9D�
	��	
�
 .sysoexecTEXT���     TEXT	� b  9@	�	�	� m  9<	�	� �	�	�  r m   - r   - f  	� o  <?�� 0 thephoto thePhoto�	  �  � 0 	photoitem 	photoItem	d o   � ��� $0 currentphotolist currentPhotoList�  � 4   S W�	�
� 
dskp	� o   U V�� 0 desktopnumber desktopNumber�L  f m     	�	��                                                                                  sevs  alis    �  Macintosh HD               ���H+  �T�System Events.app                                              �f�����        ����  	                CoreServices    ��*�      ����    �T��T��T  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  P 	�	�	� l     ����  �  �  	� 	�	�	� l     �	�	��  	� ) # SAVE WALLPAPER FROM DESKTOP NUMBER   	� �	�	� F   S A V E   W A L L P A P E R   F R O M   D E S K T O P   N U M B E R	� 	�	�	� i     #	�	�	� I      � 	����  $0 savedesktopimage saveDesktopImage	� 	�	�	� o      ���� 0 arg  	� 	�	�	� o      ���� 0 
configpath 
configPath	� 	�	�	� o      ���� 0 unsplash_api_url  	� 	�	�	� o      ���� 0 unsplash_api_client_id  	� 	�	�	� o      ���� 0 user_project_path  	� 	�	�	� o      ���� 0 user_desktop_width  	� 	�	�	� o      ���� 0 user_desktop_height  	� 	�	�	� o      ���� 0 images_directory  	� 	�	�	� o      ���� 0 current_directory  	� 	���	� o      ���� 0 saved_directory  ��  ��  	� O    d	�	�	� k   c	�	� 	�	�	� r    	�	�	� c    
	�	�	� n   	�	�	� 4   ��	�
�� 
cobj	� m    ���� 	� o    ���� 0 arg  	� m    	��
�� 
nmbr	� o      ���� 0 desktopnumber desktopNumber	� 	�	�	� r    	�	�	� I   ��	���
�� .corecnte****       ****	� 2   ��
�� 
dskp��  	� o      ���� 0 desktopcount desktopCount	� 	�	�	� Z    M	�	�	���	� G    *	�	�	� =   	�	�	� o    ���� 0 desktopnumber desktopNumber	� m    ����  	� l   (	�����	� F    (	�	�	� ?    	�	�	� o    ���� 0 desktopnumber desktopNumber	� o    ���� 0 desktopcount desktopCount	� =  # &	�	�	� o   # $���� 0 desktopcount desktopCount	� m   $ %���� ��  ��  	� r   - 2	�	�	� c   - 0	�	�	� m   - .���� 	� m   . /��
�� 
nmbr	� o      ���� 0 desktopnumber desktopNumber	� 	�	�	� F   5 @	�	�	� ?  5 8	�	�	� o   5 6���� 0 desktopnumber desktopNumber	� o   6 7���� 0 desktopcount desktopCount	� ?  ; >	�	�	� o   ; <���� 0 desktopcount desktopCount	� m   < =���� 	� 	���	� L   C I	�	� b   C H	�	�	� b   C F	�	�	� m   C D	�	� �	�	� f # 	 
 # 	 P l e a s e   s p e c i f y   a   d e s k t o p   n u m b e r   b e t w e e n   1   a n d  	� o   D E���� 0 desktopcount desktopCount	� m   F G	�	� �	�	�  . 
 # 	��  ��  	� 	���	� O   Nc	�	�	� k   Ub	�	� 	�	�	� l  U U��	�	���  	� / ) Get path of current photo (for deletion)   	� �	�	� R   G e t   p a t h   o f   c u r r e n t   p h o t o   ( f o r   d e l e t i o n )	� 	�	�	� r   U \	�	�	� e   U Z	�	� c   U Z	�	�	� 1   U X��
�� 
picP	� m   X Y��
�� 
TEXT	� o      ���� $0 currentwallpaper currentWallpaper	� 	�	�	� l  ] ]��	�	���  	� 2 , Extract name and extension of current photo   	� �	�	� X   E x t r a c t   n a m e   a n d   e x t e n s i o n   o f   c u r r e n t   p h o t o	� 	�	�	� r   ] i	�	�	� c   ] g	�	�	� n  ] e	�	�	� I   ^ e��	����� 0 replacetext replaceText	� 	�	�	� o   ^ _���� 0 current_directory  	� 
 

  m   _ `

 �

  
 
��
 o   ` a���� $0 currentwallpaper currentWallpaper��  ��  	�  f   ] ^	� m   e f��
�� 
TEXT	� o      ���� (0 currentwallpaperid currentWallpaperId	� 


 l  j j��

��  
 � � If current photo exists in current_directory, set needToFetchImage to false. If current photo is missing, set needToFetchImage to true.   
 �
	
	   I f   c u r r e n t   p h o t o   e x i s t s   i n   c u r r e n t _ d i r e c t o r y ,   s e t   n e e d T o F e t c h I m a g e   t o   f a l s e .   I f   c u r r e n t   p h o t o   i s   m i s s i n g ,   s e t   n e e d T o F e t c h I m a g e   t o   t r u e .
 




 r   j y


 I  j w��


�� .sysoexecTEXT���     TEXT
 b   j q


 b   j o


 b   j m


 m   j k

 �

  i f   [   - f   "
 o   k l���� 0 current_directory  
 o   m n���� (0 currentwallpaperid currentWallpaperId
 m   o p

 �

 P "   ] ;   t h e n   e c h o   f a l s e ;   e l s e   e c h o   t r u e ;   f i
 ��
��
�� 
rtyp
 m   r s��
�� 
TEXT��  
 o      ���� $0 needtofetchimage needToFetchImage
 


 Z   z0

����
 =  z 

 
 o   z {���� $0 needtofetchimage needToFetchImage
  m   { ~
!
! �
"
"  t r u e
 k   �,
#
# 
$
%
$ l  � ���
&
'��  
& @ : Photo does not exist in current_directory, so fetch image   
' �
(
( t   P h o t o   d o e s   n o t   e x i s t   i n   c u r r e n t _ d i r e c t o r y ,   s o   f e t c h   i m a g e
% 
)
*
) r   � �
+
,
+ c   � �
-
.
- n  � �
/
0
/ I   � ���
1���� 0 replacetext replaceText
1 
2
3
2 J   � �
4
4 
5
6
5 m   � �
7
7 �
8
8  . j p g
6 
9��
9 m   � �
:
: �
;
;  . p n g��  
3 
<
=
< m   � �
>
> �
?
?  
= 
@��
@ o   � ����� (0 currentwallpaperid currentWallpaperId��  ��  
0  f   � �
. m   � ���
�� 
TEXT
, o      ���� 0 imagetofetch imageToFetch
* 
A
B
A l  � ���
C
D��  
C   Set URL for curl   
D �
E
E "   S e t   U R L   f o r   c u r l
B 
F
G
F r   � �
H
I
H c   � �
J
K
J b   � �
L
M
L b   � �
N
O
N b   � �
P
Q
P b   � �
R
S
R b   � �
T
U
T b   � �
V
W
V b   � �
X
Y
X b   � �
Z
[
Z o   � ����� 0 unsplash_api_url  
[ m   � �
\
\ �
]
]  p h o t o s /
Y o   � ����� 0 imagetofetch imageToFetch
W m   � �
^
^ �
_
_  / ? c l i e n t _ i d =
U o   � ����� 0 unsplash_api_client_id  
S m   � �
`
` �
a
a  & w =
Q o   � ����� 0 user_desktop_width  
O m   � �
b
b �
c
c  & h =
M o   � ����� 0 user_desktop_height  
K m   � ���
�� 
TEXT
I o      ���� 0 fetchurl fetchUrl
G 
d
e
d l  � ���
f
g��  
f ) # Check if URL is valid (status 200)   
g �
h
h F   C h e c k   i f   U R L   i s   v a l i d   ( s t a t u s   2 0 0 )
e 
i
j
i r   � �
k
l
k I  � ���
m
n
�� .sysoexecTEXT���     TEXT
m b   � �
o
p
o b   � �
q
r
q m   � �
s
s �
t
t � h t t p R e s p o n s e = $ ( c u r l   - - w r i t e - o u t   " % { h t t p _ c o d e } "   - - s i l e n t   - - o u t p u t   / d e v / n u l l   "
r o   � ����� 0 fetchurl fetchUrl
p m   � �
u
u �
v
v P " )   & &   e c h o   " $ h t t p R e s p o n s e "   | |   e c h o   " 5 0 0 "
n ��
w��
�� 
rtyp
w m   � ���
�� 
TEXT��  
l o      ���� 0 httpcode httpCode
j 
x��
x Z   �,
y
z
{
|
y =  � �
}
~
} o   � ����� 0 httpcode httpCode
~ m   � �

 �
�
�  2 0 0
z k   �
�
� 
�
�
� l  � ���
�
���  
�   Fetch the image   
� �
�
�     F e t c h   t h e   i m a g e
� 
�
�
� r   � �
�
�
� I  � ���
�
�
�� .sysoexecTEXT���     TEXT
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� m   � �
�
� �
�
� " r e s p o n s e = $ ( c u r l   '
� o   � ����� 0 fetchurl fetchUrl
� m   � �
�
� �
�
�2 ' )   & &   p h o t o I d = ` e c h o   $ r e s p o n s e   |   s e d   - e   ' s / ^ { " i d " : " / / '   - e   ' s / " . * / / ' `   & &   p h o t o U r l = ` e c h o   $ r e s p o n s e   |   s e d   - e   ' s / ^ . * " c u s t o m " : " / / '   - e   ' s / " . * / / ' `   & &   c u r l   - L   - o  
� o   � ����� 0 current_directory  
� m   � �
�
� �
�
� Z " $ p h o t o I d " . j p g   " $ p h o t o U r l "   & &   e c h o   " $ p h o t o I d "
� ��
���
�� 
rtyp
� m   � ���
�� 
TEXT��  
� o      ���� "0 photoidentifier photoIdentifier
� 
�
�
� l  � ���
�
���  
�   Set desktop wallpaper   
� �
�
� ,   S e t   d e s k t o p   w a l l p a p e r
� 
���
� r   �
�
�
� b   � �
�
�
� b   � �
�
�
� o   � ����� 0 current_directory  
� o   � ����� "0 photoidentifier photoIdentifier
� m   � �
�
� �
�
�  . j p g
� 1   � ��
�� 
picP��  
{ 
�
�
� = 
�
�
� o  ���� 0 httpcode httpCode
� m  

�
� �
�
�  4 0 4
� 
���
� L  
�
� b  
�
�
� b  
�
�
� m  
�
� �
�
� l # 	 
 # 	 S o r r y ,   t h a t   i m a g e   I D   c o u l d   n o t   b e   f o u n d .   S t a t u s :  
� o  ���� 0 httpcode httpCode
� m  
�
� �
�
�  
 # 	��  
| k  ,
�
� 
�
�
� l ��
�
���  
� J D Try to repair API credentials. REMOVE NEXT LINE FOR ALFRED WORKFLOW   
� �
�
� �   T r y   t o   r e p a i r   A P I   c r e d e n t i a l s .   R E M O V E   N E X T   L I N E   F O R   A L F R E D   W O R K F L O W
� 
�
�
� n #
�
�
� I  #��
����� .0 refreshapicredentials refreshApiCredentials
� 
���
� o  ���� 0 
configpath 
configPath��  ��  
�  f  
� 
���
� L  $,
�
� b  $+
�
�
� m  $'
�
� �
�
� # 	 
 # 	 T h e r e   w a s   a   p r o b l e m   c o n n e c t i n g   t o   t h e   U n s p l a s h   A P I .   
 # 	 P l e a s e   w a i t   a   m o m e n t   a n d   t r y   y o u r   r e q u e s t   a g a i n .   
 # 	 
 # 	 I f   t h e   p r o b l e m   p e r s i s t s ,   p l e a s e   c h e c k   t h e   p r o j e c t   
 # 	 d o c u m e n t a t i o n   a t   h t t p s : / / g i t h u b . c o m / a d a m d e h a v e n / W a l l p a p e r s - f r o m - U n s p l a s h 
 # 	 
 # 	 S t a t u s   C o d e :  
� o  '*���� 0 httpcode httpCode��  ��  ��  ��  
 
�
�
� l 11��
�
���  
� m g If file isn't already in the saved_directory, copy currentWallpaper to /images/saved-wallpapers folder   
� �
�
� �   I f   f i l e   i s n ' t   a l r e a d y   i n   t h e   s a v e d _ d i r e c t o r y ,   c o p y   c u r r e n t W a l l p a p e r   t o   / i m a g e s / s a v e d - w a l l p a p e r s   f o l d e r
� 
�
�
� I 1L��
���
�� .sysoexecTEXT���     TEXT
� b  1H
�
�
� b  1D
�
�
� b  1B
�
�
� b  1>
�
�
� b  1<
�
�
� b  18
�
�
� b  16
�
�
� m  14
�
� �
�
�  i f   [   !   - f   "
� o  45���� 0 saved_directory  
� o  67���� (0 currentwallpaperid currentWallpaperId
� m  8;
�
� �
�
�   "   ] ;   t h e n   c p   - p  
� o  <=���� $0 currentwallpaper currentWallpaper
� m  >A
�
� �
�
�   
� o  BC���� 0 saved_directory  
� m  DG
�
� �
�
�  ;   f i��  
� 
�
�
� l MM��
�
���  
�   Show saved image   
� �
�
� "   S h o w   s a v e d   i m a g e
� 
�
�
� r  MV
�
�
� b  MR
�
�
� o  MN���� 0 images_directory  
� m  NQ
�
� �
�
� $ u n s p l a s h _ s a v e d . j p g
� 1  RU��
�� 
picP
� 
�
�
� I W\��
���
�� .sysodelanull��� ��� nmbr
� m  WX���� ��  
� 
�
�
� l ]]��
�
���  
�    Replace current wallpaper   
� �
�
� 4   R e p l a c e   c u r r e n t   w a l l p a p e r
� 
���
� r  ]b   o  ]^���� $0 currentwallpaper currentWallpaper 1  ^a��
�� 
picP��  	� 4   N R�
� 
dskp o   P Q�~�~ 0 desktopnumber desktopNumber��  	� m     �                                                                                  sevs  alis    �  Macintosh HD               ���H+  �T�System Events.app                                              �f�����        ����  	                CoreServices    ��*�      ����    �T��T��T  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  	�  l     �}�|�{�}  �|  �{    l     �z	�z   %  LOAD RANDOM SAVED WALLPAPER(S)   	 �

 >   L O A D   R A N D O M   S A V E D   W A L L P A P E R ( S )  i   $ ' I      �y�x�y .0 loadrandomsavedimages loadRandomSavedImages  o      �w�w 0 arg    o      �v�v 0 
configpath 
configPath  o      �u�u 0 saved_directory   �t o      �s�s 0 current_directory  �t  �x   k    �  Z     C�r l    �q�p ?     l     �o�n  I    �m!�l
�m .corecnte****       ****! o     �k�k 0 arg  �l  �o  �n   m    �j�j �q  �p   Z   
 ;"#�i$" l  
 (%�h�g% F   
 (&'& F   
 ()( ?  
 *+* n   
 ,-, 1    �f
�f 
leng- n  
 ./. 4   �e0
�e 
cobj0 m    �d�d / o   
 �c�c 0 arg  + m    �b�b  ) >   121 n   343 4   �a5
�a 
cobj5 m    �`�` 4 o    �_�_ 0 arg  2 m    66 �77  . j p g' >    &898 n    $:;: 4  ! $�^<
�^ 
cobj< m   " #�]�] ; o     !�\�\ 0 arg  9 m   $ %== �>>  r a n d o m�h  �g  # r   + 3?@? c   + 1ABA n  + /CDC 4  , /�[E
�[ 
cobjE m   - .�Z�Z D o   + ,�Y�Y 0 arg  B m   / 0�X
�X 
TEXT@ o      �W�W 0 phototoload photoToLoad�i  $ r   6 ;FGF c   6 9HIH m   6 7JJ �KK  r a n d o mI m   7 8�V
�V 
TEXTG o      �U�U 0 phototoload photoToLoad�r   r   > CLML c   > ANON m   > ?PP �QQ  r a n d o mO m   ? @�T
�T 
TEXTM o      �S�S 0 phototoload photoToLoad R�RR O   D�STS k   H�UU VWV r   H QXYX I  H O�QZ�P
�Q .corecnte****       ****Z 2  H K�O
�O 
dskp�P  Y o      �N�N 0 desktopcount desktopCountW [\[ l  R R�M]^�M  ] 5 / Add all current wallpapers to currentPhotoList   ^ �__ ^   A d d   a l l   c u r r e n t   w a l l p a p e r s   t o   c u r r e n t P h o t o L i s t\ `a` r   R Vbcb J   R T�L�L  c o      �K�K $0 currentphotolist currentPhotoLista ded Y   W zf�Jgh�If O   a uiji k   h tkk lml l  h h�Hno�H  n / ) Get name of current photo (for deletion)   o �pp R   G e t   n a m e   o f   c u r r e n t   p h o t o   ( f o r   d e l e t i o n )m qrq r   h osts e   h muu c   h mvwv 1   h k�G
�G 
picPw m   k l�F
�F 
TEXTt o      �E�E &0 previouswallpaper previousWallpaperr x�Dx s   p tyzy o   p q�C�C &0 previouswallpaper previousWallpaperz n      {|{  ;   r s| o   q r�B�B $0 currentphotolist currentPhotoList�D  j 4   a e�A}
�A 
dskp} o   c d�@�@ 0 desktopnumber desktopNumber�J 0 desktopnumber desktopNumberg m   Z [�?�? h o   [ \�>�> 0 desktopcount desktopCount�I  e ~~ l  { {�=���=  � @ : empty current_wallpapers directory to prevent stale files   � ��� t   e m p t y   c u r r e n t _ w a l l p a p e r s   d i r e c t o r y   t o   p r e v e n t   s t a l e   f i l e s ��� I  { ��<��;
�< .sysoexecTEXT���     TEXT� b   { ���� b   { ~��� m   { |�� ���  r m   - r   - f  � o   | }�:�: 0 current_directory  � m   ~ �� ���  *�;  � ��� Y   �Q��9���8� k   �L�� ��� O   �D��� k   �C�� ��� l  � ��7���7  � 0 * Check if there are images in saved folder   � ��� T   C h e c k   i f   t h e r e   a r e   i m a g e s   i n   s a v e d   f o l d e r� ��� r   � ���� I  � ��6��
�6 .sysoexecTEXT���     TEXT� b   � ���� b   � ���� m   � ��� ���  c o u n t = ` l s   - 1  � o   � ��5�5 0 saved_directory  � m   � ��� ��� V * . j p g   2 > / d e v / n u l l   |   w c   - l `   & &   e c h o   " $ c o u n t "� �4��3
�4 
rtyp� m   � ��2
�2 
TEXT�3  � o      �1�1 0 
imagecount 
imageCount� ��� l  � ��0���0  � ) # Remove whitesplace from imageCount   � ��� F   R e m o v e   w h i t e s p l a c e   f r o m   i m a g e C o u n t� ��� r   � ���� c   � ���� n  � ���� I   � ��/��.�/ 0 replacetext replaceText� ��� m   � ��� ���   � ��� m   � ��� ���  � ��-� o   � ��,�, 0 
imagecount 
imageCount�-  �.  �  f   � �� m   � ��+
�+ 
nmbr� o      �*�* 0 
imagecount 
imageCount� ��� l  � ��)�(�'�)  �(  �'  � ��&� Z   �C���%�� ?  � ���� o   � ��$�$ 0 
imagecount 
imageCount� m   � ��#�#  � k   �<�� ��� Z   � ����"�� =  � ���� o   � ��!�! 0 phototoload photoToLoad� m   � ��� ���  r a n d o m� k   � ��� ��� l  � �� ���   �   Load random image   � ��� $   L o a d   r a n d o m   i m a g e� ��� r   � ���� I  � ����
� .sysoexecTEXT���     TEXT� b   � ���� b   � ���� m   � ��� ���  s a v e d F o l d e r = (� o   � ��� 0 saved_directory  � m   � ��� ��� � * )   & &   r a n d o m I m a g e = $ ( p r i n t f   " % s "   " $ { s a v e d F o l d e r [ R A N D O M   %   $ { # s a v e d F o l d e r [ @ ] } ] } " )   & &   e c h o   " $ r a n d o m I m a g e "� ���
� 
rtyp� m   � ��
� 
TEXT�  � o      �� $0 randomsavedimage randomSavedImage�  �"  � k   � ��� ��� l  � �����  �   Load passed image   � ��� $   L o a d   p a s s e d   i m a g e� ��� l  � �����  � N H final part of command below puts result(s) in array in case two or more   � ��� �   f i n a l   p a r t   o f   c o m m a n d   b e l o w   p u t s   r e s u l t ( s )   i n   a r r a y   i n   c a s e   t w o   o r   m o r e� ��� l  � �����  � : 4 images have similar names, then grabs the first one   � ��� h   i m a g e s   h a v e   s i m i l a r   n a m e s ,   t h e n   g r a b s   t h e   f i r s t   o n e� ��� r   � ���� I  � ����
� .sysoexecTEXT���     TEXT� b   � �� � b   � � b   � � m   � � � 0 t h e i m a g e = $ ( f o r   p h o t o   i n   o   � ��� 0 saved_directory   o   � ��� 0 phototoload photoToLoad  m   � � � � * ;   d o   e c h o   $ p h o t o ;   d o n e )   & &   t h e i m a g e a r r a y = ( $ t h e i m a g e )   & &   e c h o   $ { t h e i m a g e a r r a y [ 0 ] }� �	�
� 
rtyp	 m   � ��
� 
TEXT�  � o      �� $0 randomsavedimage randomSavedImage�  � 

 l  � ���   A ; Copy randomSavedImage to /images/current-wallpapers folder    � v   C o p y   r a n d o m S a v e d I m a g e   t o   / i m a g e s / c u r r e n t - w a l l p a p e r s   f o l d e r  r   � I  ��
� .sysoexecTEXT���     TEXT b   � b   �  b   � � b   � � m   � � � * s t a t e m e n t = $ ( i f   c p   - p   o   � ��� $0 randomsavedimage randomSavedImage m   � � �      o   � ��
�
 0 current_directory   m   !! �"" � ;   t h e n   e c h o   " e x i s t s " ;   e l s e   e c h o   " n o t E x i s t s " ;   f i )   & &   e c h o   $ s t a t e m e n t �	#�
�	 
rtyp# m  �
� 
TEXT�   o      ��  0 doesimageexist doesImageExist $%$ l ����  �  �  % &'& Z  %()��( > *+* o  � �   0 doesimageexist doesImageExist+ m  ,, �--  e x i s t s) L  !.. b   /0/ b  121 m  33 �44 T # 	 
 # 	 S o r r y ,   b u t   a n   i m a g e   n a m e   c o n t a i n i n g   '2 o  ���� 0 phototoload photoToLoad0 m  55 �66 � '   c o u l d   n o t   b e   f o u n d .   
 # 	 T r y   l o o k i n g   i n   ' / W a l l p a p e r s - f r o m - U n s p l a s h / i m a g e s / s a v e d - w a l l p a p e r s '   
 # 	 f o r   y o u r   s a v e d   i m a g e s . 
 # 	�  �  ' 787 l &&��������  ��  ��  8 9:9 r  &4;<; c  &2=>= n &0?@? I  '0��A���� 0 replacetext replaceTextA BCB o  '(���� 0 saved_directory  C DED m  (+FF �GG  E H��H o  +,���� $0 randomsavedimage randomSavedImage��  ��  @  f  &'> m  01��
�� 
TEXT< o      ���� $0 randomsavedimage randomSavedImage: IJI l 55��KL��  K 7 1 Replace current wallpaper from current_directory   L �MM b   R e p l a c e   c u r r e n t   w a l l p a p e r   f r o m   c u r r e n t _ d i r e c t o r yJ N��N r  5<OPO b  58QRQ o  56���� 0 current_directory  R o  67���� $0 randomsavedimage randomSavedImageP 1  8;��
�� 
picP��  �%  � L  ?CSS m  ?BTT �UU � # 
 # 	 S o r r y ,   b u t   y o u   h a v e   n o   s a v e d   w a l l p a p e r s .   
 # 	 T r y   r u n n i n g   t h e   f o l l o w i n g   c o m m a n d : 
 # 	 $   u n s p l a s h   s a v e   [ d e s k t o p   n u m b e r ] 
 # 	�&  � 4   � ���V
�� 
dskpV o   � ����� 0 desktopnumber desktopNumber� WXW l EE��YZ��  Y . ( Add delay so all wallpapers are changed   Z �[[ P   A d d   d e l a y   s o   a l l   w a l l p a p e r s   a r e   c h a n g e dX \��\ I EL��]��
�� .sysodelanull��� ��� nmbr] m  EH^^ ?�      ��  ��  �9 0 desktopnumber desktopNumber� m   � ����� � o   � ����� 0 desktopcount desktopCount�8  � _`_ l RR��ab��  a ~ x If any photo in currentPhotoList is not loading image or saved confirmation or Apple's default desktop image, delete it   b �cc �   I f   a n y   p h o t o   i n   c u r r e n t P h o t o L i s t   i s   n o t   l o a d i n g   i m a g e   o r   s a v e d   c o n f i r m a t i o n   o r   A p p l e ' s   d e f a u l t   d e s k t o p   i m a g e ,   d e l e t e   i t` d��d X  R�e��fe k  d�gg hih r  dijkj c  dglml o  de���� 0 	photoitem 	photoItemm m  ef��
�� 
TEXTk o      ���� 0 thephoto thePhotoi n��n Z  j�op��qo G  j�rsr G  jytut E jovwv o  jk���� 0 thephoto thePhotow m  knxx �yy   u n s p l a s h _ l o a d i n gu E rwz{z o  rs���� 0 thephoto thePhoto{ m  sv|| �}}  u n s p l a s h _ s a v e ds E |�~~ o  |}���� 0 thephoto thePhoto m  }��� ���  D e f a u l t D e s k t o pp l ��������  �   Do nothing   � ���    D o   n o t h i n g��  q I �������
�� .sysoexecTEXT���     TEXT� b  ����� m  ���� ���  r m   - r   - f  � o  ������ 0 thephoto thePhoto��  ��  �� 0 	photoitem 	photoItemf o  UV���� $0 currentphotolist currentPhotoList��  T m   D E���                                                                                  sevs  alis    �  Macintosh HD               ���H+  �T�System Events.app                                              �f�����        ����  	                CoreServices    ��*�      ����    �T��T��T  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �R   ��� l     ��������  ��  ��  � ��� l     ������  �   Function Subroutines   � ��� *   F u n c t i o n   S u b r o u t i n e s� ��� l     ��������  ��  ��  � ��� i   ( +��� I      ������� (0 checkforbasherrors checkForBashErrors� ��� o      ���� 0 arg  � ���� o      ���� 0 
configpath 
configPath��  ��  � Z     ������ =    ��� n    ��� 4   ���
�� 
cobj� m    ���� � o     ���� 0 arg  � m    �� ���  d e s k t o p� L   	 �� m   	 
�� ��� � # 	 
 # 	 P l e a s e   s p e c i f y   a   d e s k t o p   n u m b e r . 
 # 	 E x a m p l e :   $   u n s p l a s h   d e s k t o p   2 
 # 	� ��� =   ��� n   ��� 4   ���
�� 
cobj� m    ���� � o    ���� 0 arg  � m    �� ��� 
 f e t c h� ��� L    �� m    �� ��� � # 	 
 # 	 P l e a s e   s p e c i f y   t h e   p h o t o   i d   f r o m   U n s p l a s h . c o m . 
 # 	 E x a m p l e :   $   u n s p l a s h   f e t c h   K q V H R m H V w w M 
 # 	� ��� =   "��� n    ��� 4    ���
�� 
cobj� m    ���� � o    ���� 0 arg  � m     !�� ���  s e a r c h� ��� L   % '�� m   % &�� ��� � # 	 
 # 	 P l e a s e   s p e c i f y   k e y w o r d ( s )   s e p a r a t e d   b y 
 # 	 c o m m a s   w i t h   n o   s p a c e s . 
 # 	 E x a m p l e :   $   u n s p l a s h   s e a r c h   s u n r i s e , c i t y 
 # 	� ��� =  * 0��� n  * .��� 4  + .���
�� 
cobj� m   , -���� � o   * +���� 0 arg  � m   . /�� ���  u s e r n a m e� ��� L   3 5�� m   3 4�� ��� � # 	 
 # 	 P l e a s e   s p e c i f y   t h e   U n s p l a s h . c o m   u s e r n a m e . 
 # 	 E x a m p l e :   $   u n s p l a s h   u s e r n a m e   s t v c r t r 
 # 	� ��� =  8 >��� n  8 <��� 4  9 <���
�� 
cobj� m   : ;���� � o   8 9���� 0 arg  � m   < =�� ���  c o l l e c t i o n� ��� L   A C�� m   A B�� ��� � # 	 
 # 	 P l e a s e   s p e c i f y   t h e   U n s p l a s h . c o m   c o l l e c t i o n   i d . 
 # 	 E x a m p l e :   $   u n s p l a s h   c o l l e c t i o n   1 6 5 9 2 1 
 # 	� ��� =  F L��� n  F J��� 4  G J���
�� 
cobj� m   H I���� � o   F G���� 0 arg  � m   J K�� ���  s a v e� ��� L   O Q�� m   O P�� ��� � # 	 
 # 	 P l e a s e   s p e c i f y   w h i c h   d e s k t o p   n u m b e r 
 # 	 h a s   t h e   i m a g e   y o u ' d   l i k e   t o   s a v e . 
 # 	 E x a m p l e :   $   u n s p l a s h   s a v e   2 
 # 	� ��� =  T Z��� n  T X��� 4  U X���
�� 
cobj� m   V W���� � o   T U���� 0 arg  � m   X Y�� ��� 
 s a v e d� ��� L   ] _�� m   ] ^�� ���T # 	 
 # 	 P l e a s e   s p e c i f y   t h e   n a m e   ( o r   p a r t i a l   n a m e )   o f   t h e 
 # 	 i m a g e   y o u   w o u l d   l i k e   t o   d i s p l a y   f r o m   
 # 	 y o u r   ' s a v e d - w a l l p a p e r s `   f o l d e r . 
 # 	 E x a m p l e :   $   u n s p l a s h   s a v e d   T Z C e h S n - T - o 
 # 	� ��� =  b h   n  b f 4  c f��
�� 
cobj m   d e����  o   b c���� 0 arg   m   f g � 
 w i d t h�  L   k r		 n  k q

 I   l q������ (0 promptmissingwidth promptMissingWidth �� o   l m���� 0 
configpath 
configPath��  ��    f   k l  =  u } n  u y 4  v y��
�� 
cobj m   w x����  o   u v���� 0 arg   m   y | �  h e i g h t �� L   � � n  � � I   � ������� *0 promptmissingheight promptMissingHeight �� o   � ����� 0 
configpath 
configPath��  ��    f   � ���  � L   � � m   � � �Z 
 # 
 # 	 Y o u   m a y   u s e   t h e   c o m m a n d   ' u n s p l a s h '   o n   i t ' s   o w n 
 # 	 t o   f e t c h   r a n d o m   w a l l p a p e r s   f o r   y o u r   d e s k t o p ( s ) . 
 # 	 A l t e r n a t i v e l y ,   y o u   m a y   u s e   o n e   o f   t h e   f o l l o w i n g 
 # 	 a r g u m e n t s   f o r   m o r e   o p t i o n s : 
 # 	 	 $   u n s p l a s h 
 # 	 	 $   u n s p l a s h   f e a t u r e d 
 # 	 	 $   u n s p l a s h   s e a r c h   [ k e y w o r d , k e y w o r d ] 
 # 	 	 $   u n s p l a s h   c o l l e c t i o n   [ c o l l e c t i o n   i d ] 
 # 	 	 $   u n s p l a s h   u s e r n a m e   [ u s e r n a m e ] 
 # 	 	 $   u n s p l a s h   f e t c h   [ p h o t o   i d ] 
 # 	 	 $   u n s p l a s h   d e s k t o p   [ d e s k t o p   # ] 
 # 	 	 $   u n s p l a s h   s a v e   [ d e s k t o p   # ] 
 # 	 	 $   u n s p l a s h   s a v e d   [ f u l l   o r   p a r t i a l   i m a g e   n a m e ] 
 # 	 	 $   u n s p l a s h   l o a d 
 # 	 
 # 	 Y o u   m a y   s e t   y o u r   d e s k t o p   d i m e n s i o n s   b y 
 # 	 u s i n g   ' w i d t h '   a n d   ' h e i g h t ' . 
 # 	 	 $   u n s p l a s h   w i d t h   [ i n t e g e r ] 
 # 	 	 $   u n s p l a s h   h e i g h t   [ i n t e g e r ] 
 # 
 # 	 T o   v i e w   t h i s   i n f o   a g a i n ,   u s e   $   u n s p l a s h   - - h e l p 
 # 	�  !  l     ��������  ��  ��  ! "#" i   , /$%$ I      ��&���� (0 promptmissingwidth promptMissingWidth& '��' o      ���� 0 
configpath 
configPath��  ��  % I    	��(��
�� .sysoexecTEXT���     TEXT( b     )*) b     +,+ m     -- �.. 2 t h e w i d t h = $ ( d e f a u l t s   r e a d  , o    ���� 0 
configpath 
configPath* m    // �00 � c o n f i g . p l i s t   u s e r _ d e s k t o p _ w i d t h )   & &   e c h o   " # 	 D e s k t o p   w i d t h   f o r   ' W a l l p a p e r s   f r o m   U n s p l a s h '   i s   s e t   t o   $ t h e w i d t h   p i x e l s . "��  # 121 l     ��������  ��  ��  2 343 i   0 3565 I      ��7���� *0 promptmissingheight promptMissingHeight7 8��8 o      ���� 0 
configpath 
configPath��  ��  6 I    	��9��
�� .sysoexecTEXT���     TEXT9 b     :;: b     <=< m     >> �?? 4 t h e h e i g h t = $ ( d e f a u l t s   r e a d  = o    ���� 0 
configpath 
configPath; m    @@ �AA � c o n f i g . p l i s t   u s e r _ d e s k t o p _ h e i g h t )   & &   e c h o   " # 	 D e s k t o p   h e i g h t   f o r   ' W a l l p a p e r s   f r o m   U n s p l a s h '   i s   s e t   t o   $ t h e h e i g h t   p i x e l s . "��  4 BCB l     ��������  ��  ��  C DED i   4 7FGF I      ��H���� 0 replacetext replaceTextH IJI o      ���� 0 find  J KLK o      ���� 0 replace  L M��M o      ���� 0 sometext someText��  ��  G k     &NN OPO r     QRQ n     STS 1    ��
�� 
txdlT 1     ��
�� 
ascrR o      ���� 0 prevtids prevTIDsP UVU r    WXW o    ���� 0 find  X n      YZY 1    
��
�� 
txdlZ 1    ��
�� 
ascrV [\[ r    ]^] n    _`_ 2   ��
�� 
citm` o    ���� 0 sometext someText^ o      ���� 0 sometext someText\ aba r    cdc o    ���� 0 replace  d n      efe 1    ��
�� 
txdlf 1    �
� 
ascrb ghg r    iji b    klk m    mm �nn  l o    �~�~ 0 sometext someTextj o      �}�} 0 sometext someTexth opo r    #qrq o    �|�| 0 prevtids prevTIDsr n      sts 1     "�{
�{ 
txdlt 1     �z
�z 
ascrp u�yu L   $ &vv o   $ %�x�x 0 sometext someText�y  E wxw l     �w�v�u�w  �v  �u  x yzy l      �t{|�t  { N H  ************************** End Subroutines **************************    | �}} �     * * * * * * * * * * * * * * * * * * * * * * * * * *   E n d   S u b r o u t i n e s   * * * * * * * * * * * * * * * * * * * * * * * * * *  z ~�s~ l     �r�q�p�r  �q  �p  �s       �o���������������o   �n�m�l�k�j�i�h�g�f�e�d�c�b�a
�n .aevtoappnull  �   � ****�m $0 getnetworkstatus getNetworkStatus�l .0 refreshapicredentials refreshApiCredentials�k .0 configuredesktopwidth configureDesktopWidth�j 00 configuredesktopheight configureDesktopHeight�i &0 fetchrandomimages fetchRandomImages�h (0 fetchspecificimage fetchSpecificImage�g 80 fetchrandomimagefordesktop fetchRandomImageForDesktop�f $0 savedesktopimage saveDesktopImage�e .0 loadrandomsavedimages loadRandomSavedImages�d (0 checkforbasherrors checkForBashErrors�c (0 promptmissingwidth promptMissingWidth�b *0 promptmissingheight promptMissingHeight�a 0 replacetext replaceText� �` �_�^���]
�` .aevtoappnull  �   � ****�_ 0 arg  �^  � �\�\ 0 arg  � W�[�Z�Y +�X�W 5�V H J�U�T W Y�S�R�Q�P ��O ��N ��M � ��L � ��K � ��J�I�H�G �F$8O�E_|~����D��C�������B�A��@�?�>68G�=����<��;�Gu�:�9���8��7
�[ 
rtyp
�Z 
TEXT
�Y .earsffdralis        afdr
�X 
psxp�W 0 user_project_path  �V 0 
configpath 
configPath
�U .sysoexecTEXT���     TEXT�T 0 user_desktop_width  �S 0 user_desktop_height  
�R 
leng�Q (0 promptmissingwidth promptMissingWidth�P *0 promptmissingheight promptMissingHeight�O 0 images_directory  �N 0 current_directory  �M 0 saved_directory  �L 0 unsplash_api_url  �K 0 unsplash_api_client_id  �J 0 unsplash_initial_run  �I "0 networkrequired networkRequired
�H .corecnte****       ****
�G 
cobj
�F 
bool�E .0 refreshapicredentials refreshApiCredentials�D 0 apiconnection apiConnection�C .0 credentialsconnection credentialsConnection�B 	�A &0 fetchrandomimages fetchRandomImages�@ �? .0 loadrandomsavedimages loadRandomSavedImages�> 0 passedstring passedString�= (0 checkforbasherrors checkForBashErrors�< 80 fetchrandomimagefordesktop fetchRandomImageForDesktop�; (0 fetchspecificimage fetchSpecificImage�: 
�9 $0 savedesktopimage saveDesktopImage�8 .0 configuredesktopwidth configureDesktopWidth�7 00 configuredesktopheight configureDesktopHeight�]K)��l �%�,E�O��%�&E�O��%�%��l 
E�O��%�%��l 
E�O��,k )�k+ Y hO��,k )�k+ Y hO�a %�&E` O_ a %�&E` O_ a %�&E` Oa �%a %��l 
E` Oa �%a %��l 
E` Oa �%a %��l 
E`  OeE` !O�j "j j�a #k/a $ 
 �a #k/a % a &&
 �j "j	 �a #k/a ' a &&a &&
 �j "j	 �a #k/a ( a &&a && 
fE` !Y hY hO_ !e 
 _  a ) a && �_ �,k
 _  a * a && )�k+ +Oa ,Y hOa -_ %a .%_ %a /%�%a 0%�%a 1%��l 
E` 2Oa 3��l 
E` 4O_ 2a 5 
 _ 4a 6 a && 	a 7Y "_ 2a 8 
 _ 4a 9 a && 	a :Y hY hO�j "j  *��_ _ ���_ _ a ;+ <Y5�j "k 	 �a #k/a = a && *��_ _ a >+ ?Y�j "l 	 �a #k/a @ a && �a #l/�&E` AOa B_ A%a C%YѠj "k 	 �a #k/a D a && *��_ _ ���_ _ a ;+ <Y��j "k 
 �j "la && )��l+ EYy�j "l 
 �a #k/a F a &&
 �a #k/a G a &&F�a #k/a H  *��_ _ ���_ _ a ;+ IY�a #k/a J  *��_ _ ���_ _ a ;+ KY �a #k/a L  *��_ _ ���_ _ a ;+ <Y ˠa #k/a M  *��_ _ ���_ _ a ;+ <Y ��a #k/a N  *��_ _ ���_ _ a ;+ <Y {�a #k/a O   *��_ _ ���_ _ _ a P+ QY P�a #k/a R  *��_ _ a >+ ?Y 1�a #k/a S  *��l+ TY �a #k/a U  *��l+ VY hY 	*��l+ E� �6��5�4���3�6 $0 getnetworkstatus getNetworkStatus�5 �2��2 �  �1�1 0 testurl testURL�4  � �0�0 0 testurl testURL� �/
�/ .sysoexecTEXT���     TEXT�3 �%�%j � �.�-�,���+�. .0 refreshapicredentials refreshApiCredentials�- �*��* �  �)�) 0 
configpath 
configPath�,  � �(�'�&�( 0 
configpath 
configPath�' 0 unsplash_api_url  �& 0 unsplash_api_client_id  � �%�$�#,.0=KMOWY
�% 
rtyp
�$ 
TEXT
�# .sysoexecTEXT���     TEXT�+ :���l E�O�%�%�%�%j O���l E�O�%�%�%�%j O�%�%j � �"e�!� ����" .0 configuredesktopwidth configureDesktopWidth�! ��� �  ��� 0 arg  � 0 
configpath 
configPath�   � ���� 0 arg  � 0 
configpath 
configPath� 0 desktopwidth desktopWidth� �������
� 
cobj
� 
nmbr
� .sysoexecTEXT���     TEXT� ��l/�&E�O�%�%�%�%�%�%j � �������� 00 configuredesktopheight configureDesktopHeight� ��� �  ��� 0 arg  � 0 
configpath 
configPath�  � ���� 0 arg  � 0 
configpath 
configPath� 0 desktopheight desktopHeight� ��
�����	
� 
cobj
�
 
nmbr
�	 .sysoexecTEXT���     TEXT� ��l/�&E�O�%�%�%�%�%�%j � �������� &0 fetchrandomimages fetchRandomImages� ��� 	� 	 ���� ����������� 0 arg  � 0 
configpath 
configPath� 0 unsplash_api_url  �  0 unsplash_api_client_id  �� 0 user_project_path  �� 0 user_desktop_width  �� 0 user_desktop_height  �� 0 images_directory  �� 0 current_directory  �  � ������������������������������������������ 0 arg  �� 0 
configpath 
configPath�� 0 unsplash_api_url  �� 0 unsplash_api_client_id  �� 0 user_project_path  �� 0 user_desktop_width  �� 0 user_desktop_height  �� 0 images_directory  �� 0 current_directory  �� 0 	userinput 	userInput�� 0 	userquery 	userQuery�� 0 desktopcount desktopCount�� $0 currentphotolist currentPhotoList�� 0 desktopnumber desktopNumber�� &0 previouswallpaper previousWallpaper�� 0 fetchurl fetchUrl�� 0 httpcode httpCode�� "0 photoidentifier photoIdentifier�� 0 	photoitem 	photoItem�� 0 thephoto thePhoto� 6������9B\e~����������������')+:D��O_akv��������������
�� .corecnte****       ****
�� 
cobj
�� 
TEXT
�� 
dskp
�� 
picP
�� .sysoexecTEXT���     TEXT
�� 
rtyp
�� 
bool�� .0 refreshapicredentials refreshApiCredentials
�� 
kocl�|�j  j q��k/�  ��&E�O��&E�Y W��k/�  ��l/�&E�O�%�&E�Y ;��k/�  ��l/�&E�O�%�&E�Y ��k/�  ��l/�&E�O�%�&E�Y hY ��&E�O��*�-j  E�OjvE�O "k�kh *�/ *�,�&E�O��6GU[OY��Oa �%a %j O^k�kh *�/J�a %�%�%a %�%a %�%�&E�Oa �%a %a �l E^ O] a   8�a %*�,FOa �%a %�%a %a �l E^ O�] %a %*�,FY �] a  	 �j  ja  &	 ��k/a ! a  & a "�%a #%Y �] a $ 	 �j  ja  &	 ��k/a % a  & a &�%a '%Y r] a ( 	 �j  ja  &	 ��k/a ) a  & a *�%a +%Y >�j  j	 ��k/a , a  & )�k+ -Oa .�%a /%Y )�k+ -Oa 0] %U[OY��O U�[a 1�l  kh ] �&E^ O] a 2
 ] a 3a  &
 ] a 4a  & hY a 5] %j [OY��U� ��$���������� (0 fetchspecificimage fetchSpecificImage�� ����� 	� 	 �������������������� 0 arg  �� 0 
configpath 
configPath�� 0 unsplash_api_url  �� 0 unsplash_api_client_id  �� 0 user_project_path  �� 0 user_desktop_width  �� 0 user_desktop_height  �� 0 images_directory  �� 0 current_directory  ��  � ���������������������������������������� 0 arg  �� 0 
configpath 
configPath�� 0 unsplash_api_url  �� 0 unsplash_api_client_id  �� 0 user_project_path  �� 0 user_desktop_width  �� 0 user_desktop_height  �� 0 images_directory  �� 0 current_directory  �� 0 imagetofetch imageToFetch�� 0 desktopcount desktopCount�� $0 currentphotolist currentPhotoList�� 0 desktopnumber desktopNumber�� &0 previouswallpaper previousWallpaper�� 0 fetchurl fetchUrl�� 0 httpcode httpCode�� "0 photoidentifier photoIdentifier�� 0 	photoitem 	photoItem�� 0 thephoto thePhoto� !G����������wy���������������������59��=E
�� 
cobj
�� 
TEXT
�� 
dskp
�� .corecnte****       ****
�� 
picP
�� .sysoexecTEXT���     TEXT
�� 
rtyp�� .0 refreshapicredentials refreshApiCredentials
�� 
kocl
�� 
bool��<�8��l/�&E�O*�-j E�OjvE�O "k�kh *�/ *�,�&E�O��6GU[OY��O�%�%j O �k�kh *�/ ���%�%�%�%�%�%�%�%�&E�O��%�%��l E�O�a   6�a %*�,FOa �%a %�%a %��l E^ O�] %a %*�,FY $�a   a �%a %Y )�k+ Oa �%U[OY�pO U�[a �l kh ] �&E^ O] a 
 ] a a &
 ] a a & hY a  ] %j [OY��U� ��R���������� 80 fetchrandomimagefordesktop fetchRandomImageForDesktop�� ����� 	� 	 �������������������� 0 arg  �� 0 
configpath 
configPath�� 0 unsplash_api_url  �� 0 unsplash_api_client_id  �� 0 user_project_path  �� 0 user_desktop_width  �� 0 user_desktop_height  �� 0 images_directory  �� 0 current_directory  ��  � ���������������������������������������� 0 arg  �� 0 
configpath 
configPath�� 0 unsplash_api_url  �� 0 unsplash_api_client_id  �� 0 user_project_path  �� 0 user_desktop_width  �� 0 user_desktop_height  �� 0 images_directory  �� 0 current_directory  �� 0 desktopnumber desktopNumber�� 0 desktopcount desktopCount�� $0 currentphotolist currentPhotoList�� &0 previouswallpaper previousWallpaper�� 0 deletephoto deletePhoto�� 0 fetchurl fetchUrl�� 0 httpcode httpCode�� "0 photoidentifier photoIdentifier�� 0 	photoitem 	photoItem�� 0 thephoto thePhoto� "	������������������������			����		!	6	8	:	I��	[��	v	z	~	�
�� 
cobj
�� 
nmbr
�� 
dskp
�� .corecnte****       ****
�� 
bool
�� 
picP
�� 
TEXT
�� 
rtyp
�� .sysoexecTEXT���     TEXT�� .0 refreshapicredentials refreshApiCredentials
�� 
kocl��L�H��l/�&E�O*�-j E�O�j 
 ��	 �k �&�& 
k�&E�Y ��	 �k�& �%�%Y hOjvE�O*�/ �*�,�&E�O��6GO��
 ���& �E�Y 	��%�&E�O��%�%�%�%a %�%�&E�Oa �%a %a �l E�O�a   8�a %*�,FOa �%a %�%a %a �l E^ O�] %a %*�,FY )�k+ Oa �%O Q�[a �l kh ] �&E^ O] a 
 ] a �&
 ] a  �& hY a !] %j [OY��UU� ��	����������� $0 savedesktopimage saveDesktopImage�� ����� 
� 
 ����~�}�|�{�z�y�x�w�� 0 arg  � 0 
configpath 
configPath�~ 0 unsplash_api_url  �} 0 unsplash_api_client_id  �| 0 user_project_path  �{ 0 user_desktop_width  �z 0 user_desktop_height  �y 0 images_directory  �x 0 current_directory  �w 0 saved_directory  ��  � �v�u�t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�v 0 arg  �u 0 
configpath 
configPath�t 0 unsplash_api_url  �s 0 unsplash_api_client_id  �r 0 user_project_path  �q 0 user_desktop_width  �p 0 user_desktop_height  �o 0 images_directory  �n 0 current_directory  �m 0 saved_directory  �l 0 desktopnumber desktopNumber�k 0 desktopcount desktopCount�j $0 currentwallpaper currentWallpaper�i (0 currentwallpaperid currentWallpaperId�h $0 needtofetchimage needToFetchImage�g 0 imagetofetch imageToFetch�f 0 fetchurl fetchUrl�e 0 httpcode httpCode�d "0 photoidentifier photoIdentifier� *�c�b�a�`�_	�	��^�]
�\

�[�Z
!
7
:
>
\
^
`
b
s
u

�
�
�
�
�
�
��Y
�
�
�
�
�
��X
�c 
cobj
�b 
nmbr
�a 
dskp
�` .corecnte****       ****
�_ 
bool
�^ 
picP
�] 
TEXT�\ 0 replacetext replaceText
�[ 
rtyp
�Z .sysoexecTEXT���     TEXT�Y .0 refreshapicredentials refreshApiCredentials
�X .sysodelanull��� ��� nmbr��e�a��l/�&E�O*�-j E�O�j 
 ��	 �k �&�& 
k�&E�Y ��	 �k�& �%�%Y hO*�/*�,�&E�O)��m+ �&E�O�%�%�%��l E�O�a   �)a a lva �m+ �&E�O�a %�%a %�%a %�%a %�%�&E^ Oa ] %a %��l E^ O] a   .a ] %a %�%a %��l E^ O�] %a %*�,FY *] a   a  ] %a !%Y )�k+ "Oa #] %Y hOa $�%�%a %%�%a &%�%a '%j O�a (%*�,FOlj )O�*�,FUU� �W�V�U���T�W .0 loadrandomsavedimages loadRandomSavedImages�V �S��S �  �R�Q�P�O�R 0 arg  �Q 0 
configpath 
configPath�P 0 saved_directory  �O 0 current_directory  �U  � �N�M�L�K�J�I�H�G�F�E�D�C�B�A�N 0 arg  �M 0 
configpath 
configPath�L 0 saved_directory  �K 0 current_directory  �J 0 phototoload photoToLoad�I 0 desktopcount desktopCount�H $0 currentphotolist currentPhotoList�G 0 desktopnumber desktopNumber�F &0 previouswallpaper previousWallpaper�E 0 
imagecount 
imageCount�D $0 randomsavedimage randomSavedImage�C  0 doesimageexist doesImageExist�B 0 	photoitem 	photoItem�A 0 thephoto thePhoto� *�@�?�>6�==�<JP��;�:���9���8���7�6���!,35FT^�5�4x|��
�@ .corecnte****       ****
�? 
cobj
�> 
leng
�= 
bool
�< 
TEXT
�; 
dskp
�: 
picP
�9 .sysoexecTEXT���     TEXT
�8 
rtyp�7 0 replacetext replaceText
�6 
nmbr
�5 .sysodelanull��� ��� nmbr
�4 
kocl�T��j  k 6��l/�,j	 
��l/��&	 
��l/��& ��l/�&E�Y ��&E�Y ��&E�O�R*�-j  E�OjvE�O "k�kh *�/ *�,�&E�O��6GU[OY��O�%�%j O �k�kh *�/ ��%a %a �l E�O)a a �m+ a &E�O�j ��a   a �%a %a �l E�Y a �%�%a %a �l E�Oa �%a %�%a %a �l E�O�a  a �%a  %Y hO)�a !�m+ �&E�O��%*�,FY a "UOa #j $[OY�=O E�[a %�l  kh ��&E�O�a &
 	�a '�&
 	�a (�& hY a )�%j [OY��U� �3��2�1���0�3 (0 checkforbasherrors checkForBashErrors�2 �/��/ �  �.�-�. 0 arg  �- 0 
configpath 
configPath�1  � �,�+�, 0 arg  �+ 0 
configpath 
configPath� �*���������������)�(
�* 
cobj�) (0 promptmissingwidth promptMissingWidth�( *0 promptmissingheight promptMissingHeight�0 ���k/�  �Y ���k/�  �Y t��k/�  �Y f��k/�  �Y X��k/�  �Y J��k/�  �Y <��k/�  �Y .��k/�  )�k+ Y ��k/a   )�k+ Y a � �'%�&�%���$�' (0 promptmissingwidth promptMissingWidth�& �#��# �  �"�" 0 
configpath 
configPath�%  � �!�! 0 
configpath 
configPath� -/� 
�  .sysoexecTEXT���     TEXT�$ 
�%�%j � �6������ *0 promptmissingheight promptMissingHeight� ��� �  �� 0 
configpath 
configPath�  � �� 0 
configpath 
configPath� >@�
� .sysoexecTEXT���     TEXT� 
�%�%j � �G������ 0 replacetext replaceText� ��� �  ���� 0 find  � 0 replace  � 0 sometext someText�  � ����� 0 find  � 0 replace  � 0 sometext someText� 0 prevtids prevTIDs� ��
�	m
� 
ascr
�
 
txdl
�	 
citm� '��,E�O���,FO��-E�O���,FO�%E�O���,FO�ascr  ��ޭ