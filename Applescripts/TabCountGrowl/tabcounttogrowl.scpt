FasdUAS 1.101.10   ��   ��    k             l     ��  ��    ; 5 AppleScript to get # of tabs and report it via Growl     � 	 	 j   A p p l e S c r i p t   t o   g e t   #   o f   t a b s   a n d   r e p o r t   i t   v i a   G r o w l   
  
 l     ��������  ��  ��     ��  l     ����  O         k           I   	������
�� .miscactvnull��� ��� null��  ��        r   
     n   
     1    ��
�� 
pidx  n   
     4   �� 
�� 
bTab  m    ������  4  
 �� 
�� 
cwin  m    ����   o      ���� 0 numtabs        I   �� ��
�� .sysodlogaskr        TEXT  o    ���� 0 numtabs  ��       !   l   ��������  ��  ��   !  "�� " l    �� # $��   #��tell application "GrowlHelperApp.app"		set the allNotificationsList to {"Number of Tabs"}		set the enabledNotificationsList to {"Number of Tabs"}		�event register� given �class appl�:"Growl AppleScript Sample", �class anot�:allNotificationsList, �class dnot�:enabledNotificationsList, �class iapp�:"WebKit"				�event notifygr� given �class name�:"Number of Tabs", �class titl�:"Number of Tabs", �class desc�:"" & numtabs, �class appl�:"Growl AppleScript Sample"	end tell    $ � % %� t e l l   a p p l i c a t i o n   " G r o w l H e l p e r A p p . a p p "  	 	 s e t   t h e   a l l N o t i f i c a t i o n s L i s t   t o   { " N u m b e r   o f   T a b s " }  	 	 s e t   t h e   e n a b l e d N o t i f i c a t i o n s L i s t   t o   { " N u m b e r   o f   T a b s " }  	 	 � e v e n t   r e g i s t e r �   g i v e n   � c l a s s   a p p l � : " G r o w l   A p p l e S c r i p t   S a m p l e " ,   � c l a s s   a n o t � : a l l N o t i f i c a t i o n s L i s t ,   � c l a s s   d n o t � : e n a b l e d N o t i f i c a t i o n s L i s t ,   � c l a s s   i a p p � : " W e b K i t "  	 	  	 	 � e v e n t   n o t i f y g r �   g i v e n   � c l a s s   n a m e � : " N u m b e r   o f   T a b s " ,   � c l a s s   t i t l � : " N u m b e r   o f   T a b s " ,   � c l a s s   d e s c � : " "   &   n u m t a b s ,   � c l a s s   a p p l � : " G r o w l   A p p l e S c r i p t   S a m p l e "  	 e n d   t e l l��    m      & &�                                                                                  sfri  alis    8  Menlo                      �u� H+     Q
Safari.app                                                       !I͜:�        ����  	                Applications    �u�      ͜��       Q  Menlo:Applications: Safari.app   
 S a f a r i . a p p    M e n l o  Applications/Safari.app   / ��  ��  ��  ��       �� ' (��   ' ��
�� .aevtoappnull  �   � **** ( �� )���� * +��
�� .aevtoappnull  �   � **** ) k      , ,  ����  ��  ��   *   +  &������������
�� .miscactvnull��� ��� null
�� 
cwin
�� 
bTab
�� 
pidx�� 0 numtabs  
�� .sysodlogaskr        TEXT�� � *j O*�k/�i/�,E�O�j OPU ascr  ��ޭ