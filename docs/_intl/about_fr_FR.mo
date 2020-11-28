��    :      �  O   �      �  G   �     A  *   G  (   r  8   �     �     �     �  =   	  
   G     R  #   m  �   �  �  $  =   "	     `	  -   y	  '   �	     �	  :   �	     
     5
     L
     [
  0   k
  .   �
    �
  n  �     L     l  .   y  K  �  /   �  �  $          ,  �   3       1  )  �  [    	  �   '    �  ~   �  �   V    �  �   l"  T  �"     N$     V$     n$  �  �$  �   >&     '     ''  7   A'  Y   y'  ,  �'  ]    )  	   ^)  *   h)  (   �)  :   �)     �)     	*     *  =   3*     q*     *  ,   �*  �   �*  q  �+  =   �-     1.  -   J.  '   x.     �.  :   �.     �.     /     $/     ;/  0   T/  .   �/  �  �/  �  �2     5     �5  .   �5  �  �5  /   �8  5  �8     �:     ;  #  ;     @<  �  N<  0  �=  4  @    8A  �  >B  �    F  �   �F  �  tG  �   GM  �  N     �O     �O      �O  S  �O  �   :R     'S     GS  7   fS  Y   �S     :              3   9                           8   7      .      &   ,             5      !   2   (      $                                                  "   0                      %          /   )              6       -      4   *   
          '   #   +          1   	              *Names below in parenthesis are screen names on Trainboard and Discord* About Anthony W - Dayton, Ohio, USA (Dex, Dex++) Chris Harlow - Bournemouth, UK (UKBloke) Click here for `The DCC++ EX Team Credits <index.html>`_ CommandStation-EX DCC++ Classic DCC++ EX is all new! Dave Cutting - Logan, Utah, USA (Dave Cutting/ David Cutting) Developers Documentation / Management Everything you loved is still there First, a special thanks to Gregg E. Berman who had the original idea for a model railroad Command Station using an Arduino Uno and a Motor Shield. First, we want to stress that we didn't break anything! Whether you are using JMRI as a front end to send commands to your track, handle turnouts or read and write CVs, or any using any other software or the serial monitor, the commands are still the same. We have expanded the API (Application Programming Interface) to add new commands and provide new responses, but they won't affect your old control methods. One example of a new command is the one to handle turning power on and off to individual tracks. Fred Decker - Holly Springs, North Carolina, USA (FlightRisk) Fred Decker October 2020 Gregor Baues - Île-de-France, France (grbba) Harald Barth - Stockholm, Sweden (Haba) Installer Software Keith Ledbetter - Chicago, Illinois, USA (Keith Ledbetter) Kevin Smith - (KCSmith) Larry Dribin - (H0Guy) Lead Developer Lead Developers Mani Kumar - Bangalor, India (Mani / Mani Kumar) Mike Dunston - Sonora, California, USA (Atani) Next we focused on packet generation. We looked at the complexities of reading and maintaining code that was using binary math, multiple "registers" to hold train data, and doing bit shifting everywhere to build bytes and stuff them into data packets. The new method gets rid of the old registers and simplifies the whole structure for building packets. Things like start and stop bits and preamble bits are static pieces of information. Do being able to just insert them where they need to go saves time and processor bandwidth. Next, the Waveform Generator needed 2 timers and interrupts, one for the Main track signal and one for the Programming track. The Uno only has 3 timers. So 2 of them were already tied up for sending the DCC signal. Since the programming track sits idle most of the time, and both signals were always being generated to the input of the motor board, processing power was being wasted that could be put to use for something else. In addition, because of the way the Arduino is designed, we were forced to use jumpers to connect pins on the Arduino to those on the motor board. Our new design eliminates the need for jumpers! Paul - Virginia, USA (Paul1361) Project Lead Roger Beschizza - Dorset, UK (Roger Beschizza) So while maintaining proper deference to Gregg Bermann's original concept of an inexpensive Command Station based on the Arduino platform, we don't want to do a disservice to DCC++ EX or develpers like Chris Harlow (UkBloke) and Dave Cutting who brought a new vision to the project and who used very little of the original code. This is NOT DCC++ v2.0, this is a completely new, yet API and feature compatible Command Station. And just a tease: What Command Station would be complete without a wireless Cab Controller that speaks DCC++? Keep looking at our web page for new announcments. Sumner Patterson - Blanding, Utah, USA (Sumner) TPL brings new capability to the world of automation. You don't have to be a programmer to write a script that tells a train to start moving forward at a set speed until some action (like reaching a sensor) occurs. We will be providing a document and tutorial on TPL once Beta testing is complete. This will be an open-ended project since who knows what people will come up with they want to automate. It will be easy to extend the commands to handle whatever your imagination can dream of. Testing / Research / Support Thanks The 3 most requested features were: 1. More reliable CV read and writes, 2. Railcom cut-out, 3. Automation. We haven't limited ourselves to just these features, but we put a lot of time into redesigning things to accomodate them. The bottom line The current detection routines are completely different. One key difference is all current readings are in milliAmps instead of meaningless pin readings. So if you want to set your overload protection to kick in at 3 Amps, you just enter 3000 for 3000 milliAmps instead of looking up a value from a table. The packet generation routine was complex, hard to maintain, and limited us with regard to the hardware we could run on and new features we could implement (like the Railcom cut-out). We replaced the slow DigitalRead() and DigitalWrite() routines with a fast write library. The packet generation is now streamlined, fast (which allows us to be able to use on only 1 timer to create signals for 2 tracks), and much easier to read. This is a team effort. There are a dedicated and organize group of about 15-20 core people involved in the project. In addition, there is all of you who contribute with your comments, feature ideas, evangelizing and testing. So we give you our heartfelt thanks. We will see you online! We added many functions like individual track power control, user add-on functions, a much simpler Function (F0-28) command, better turnout handling and more. We are still testing all the motorboard and Arduino combinations at different voltages to refine our current readings. This is important because we want to have accurate and fast short-circuit detection, and because the reason CV reading was occasionally unreliable in the past was due to not always sensing a current pulse on the track. In addition to more accurately reading current, we had to completely change the way we look for an "ACK" (acknowledgement from the train that it received a command). So we now check immedately after we send a command instead of waiting for a dozen or more packets. This means we don't miss an ACK while this is happening and we jump out of sending uneccessary packes as soon as we get one. You will appreciate how much faster we can read CVs now! We completely re-wrote current sense and ACK detect routines to better protect your trains and make programming more accurate. We created an internal API for how modules communicated with each other. So the code is more modular and each unit is dedicated to its specific task. We needed a platform that would allow us to grow into the future. The first thing we found was that in order to allow easy changes and to be able to adapt to technology we might want to use going forward, the code needed to be more modular. Each unit needed to be a "black box" that either did just one task and do it well, or take input and generate output without having to know anything about the module it was communiating with. Therefore, we created an interal API through which the modules could communicate. By simply unplugging one unit and plugging in another we could continue to work using a differnt devices. An example of this is input and output. It doesn't matter whether JMRI is sending commands to DCC++ EX or if it is a wireless Cab Controller. It doesn't matter if the output device is the serial monitor or an I2C display. It doesn't matter if you want to use a serial port or a network device to route data. This makes it very easy to implement new features with new devices. We just have to create a small interface for whatever new device we want to implement. This has the side benefit of allowing the code to be more readable. We not only have created a RailCom cutout within the Command Station, but are developing a wat of reading the RailCom data and reporting it. We started with the DCC Signal Generation code, what we call the "Waveform Generator". We got together as a team and looked at how we could make it better. It soon became clear that rather than make piecemeal changes, the entire concept of how the signal could be generated and how to use timers and interrupts would need to be re-imagined. Website What's New in DCC++ EX? What's different? While we made minor changes to the original DCC++ "BaseStation-Classic", all new development is going forward with DCC++ EX. At first, we expanded features, added functionality and fixed bugs by working from the existing code base. The first release of DCC++ will be familiar to any of you who played with the code. However, we want to stress that the next release, the one that is in Beta testing now, is a complete re-write from the ground up. Who is behind all this? And will they ever face justice? Who knows, but the following is a list of those names associated with taking over the DCC++ BaseStation Project and rewriting/expanding it into "DCC++ EX". Why did we do this? You can seek us out here: `DCC++ EX Discord Server <https://discord.gg/y2sB4Fp>`_ `TrainBoard DCC++ Forum <https://www.trainboard.com/highball/index.php?forums/dcc.177/>`_ Project-Id-Version: DCC++ EX
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2020-11-24 14:41+0100
Language-Team: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 2.4.2
Last-Translator: 
Plural-Forms: nplurals=2; plural=(n > 1);
Language: fr_FR
 *Les noms ci-dessous entre parenthèses sont des noms d’écrans sur Trainboard et Discord*. À propos Anthony W - Dayton, Ohio, USA (Dex, Dex++) Chris Harlow - Bournemouth, UK (UKBloke) Cliquez ici pour `The DCC++ EX Team Credits <index.html>`_ CommandStation-EX DCC++ Classic DCC++ EX est tout nouveau ! Dave Cutting - Logan, Utah, USA (Dave Cutting/ David Cutting) Développeurs Documentation / Management Tout ce que vous avez aimé est toujours là Tout d’abord, un merci particulier à Gregg E. Berman qui a eu l’idée originale d’un poste de commandement de chemin de fer miniature utilisant un Arduino Uno et un Motor Shield. Tout d’abord, nous voulons souligner que nous n’avons rien cassé ! Que vous utilisiez JMRI comme frontal pour envoyer des commandes à votre piste, gérer des aiguillages ou lire et écrire des CV, ou que vous utilisiez tout autre logiciel ou le moniteur série, les commandes restent les mêmes. Nous avons développé l’API (Application Programming Interface) pour ajouter de nouvelles commandes et fournir de nouvelles réponses, mais elles n’affecteront pas vos anciennes méthodes de contrôle. Un exemple de nouvelle commande est celle qui permet de gérer la mise sous tension et hors tension de chaque piste. Fred Decker - Holly Springs, North Carolina, USA (FlightRisk) Fred Decker October 2020 Gregor Baues - Île-de-France, France (grbba) Harald Barth - Stockholm, Sweden (Haba) Logiciel d’installation Keith Ledbetter - Chicago, Illinois, USA (Keith Ledbetter) Kevin Smith - (KCSmith) Larry Dribin - (H0Guy) Développeur principal Développeurs principaux Mani Kumar - Bangalor, India (Mani / Mani Kumar) Mike Dunston - Sonora, California, USA (Atani) Ensuite, nous nous sommes concentrés sur la génération de paquets. Nous avons examiné la complexité de la lecture et de la maintenance du code qui utilise des mathématiques binaires, de multiples « registres » pour contenir les données des trains, et du décalage des bits partout pour construire des octets et les mettre dans des paquets de données. La nouvelle méthode se débarrasse des anciens registres et simplifie toute la structure de construction des paquets. Des éléments comme les bits de départ et d’arrêt et les bits de préambule sont des informations statiques. Le fait de pouvoir les insérer simplement là où ils doivent aller permet d’économiser du temps et de la bande passante du processeur. Ensuite, le générateur de forme d’onde a eu besoin de 2 minuteries et interruptions, une pour le signal de la voie principale et une pour la voie de programmation. L’Uno n’a que 3 minuteries. Deux d’entre eux étaient donc déjà occupés à envoyer le signal DCC. Comme la voie de programmation reste inactive la plupart du temps et que les deux signaux étaient toujours générés à l’entrée de la carte moteur, on gaspillait une puissance de traitement qui pouvait être utilisée pour autre chose. De plus, en raison de la conception de l’Arduino, nous étions obligés d’utiliser des cavaliers pour relier les broches de l’Arduino à celles de la carte moteur. Notre nouvelle conception élimine le besoin de cavaliers ! Paul - Virginia, USA (Paul1361) Chef de projet Roger Beschizza - Dorset, UK (Roger Beschizza) Ainsi, tout en respectant le concept original de Gregg Bermann d’un poste de commandement peu coûteux basé sur la plate-forme Arduino, nous ne voulons pas rendre un mauvais service à DCC++ EX ou à des développeurs comme Chris Harlow (UkBloke) et Dave Cutting qui ont apporté une nouvelle vision au projet et qui ont utilisé très peu de code original. Il ne s’agit PAS de DCC++ v2.0, mais d’une toute nouvelle station de commande compatible avec l’API et les fonctionnalités. Et c’est juste une allusion : Quel poste de commande serait complet sans un contrôleur de cabine sans fil qui parle DCC++ ? Continuez à consulter notre page web pour les nouvelles annonces. Sumner Patterson - Blanding, Utah, USA (Sumner) La TPL apporte de nouvelles capacités au monde de l’automatisation. Il n’est pas nécessaire d’être programmeur pour écrire un script qui dit à un train de commencer à avancer à une vitesse déterminée jusqu’à ce qu’une action (comme atteindre un capteur) se produise. Nous fournirons un document et un tutoriel sur TPL une fois que les tests bêta seront terminés. Ce sera un projet ouvert, car qui sait ce que les gens trouveront à automatiser. Il sera facile d’étendre les commandes pour traiter tout ce dont votre imagination peut rêver. Tests / Recherche / Soutien Merci beaucoup Les 3 fonctionnalités les plus demandées étaient : 1. Lecture et écriture de CV plus fiables, 2. coupure de Railcom, 3. automatisation. Nous ne nous sommes pas limités à ces fonctionnalités, mais nous avons passé beaucoup de temps à revoir la conception des choses pour les adapter. L’essentiel Les routines de détection actuelles sont complètement différentes. Une différence essentielle est que toutes les lectures actuelles sont en milliAmps au lieu de lectures de broches sans signification. Ainsi, si vous voulez régler votre protection contre les surcharges à 3 ampères, il vous suffit d’entrer 3000 pour 3000 milliAmps au lieu de chercher une valeur dans un tableau. La routine de génération de paquets était complexe, difficile à maintenir et nous limitait quant au matériel sur lequel nous pouvions fonctionner et aux nouvelles fonctionnalités que nous pouvions mettre en œuvre (comme le cut-out de Railcom). Nous avons remplacé les routines lentes DigitalRead() et DigitalWrite() par une bibliothèque d’écriture rapide. La génération de paquets est maintenant rationalisée, rapide (ce qui nous permet de n’utiliser qu’un seul timer pour créer des signaux pour deux voies) et beaucoup plus facile à lire. Il s’agit d’un travail d’équipe. Un groupe d’environ 15 à 20 personnes est impliqué dans le projet. De plus, vous êtes tous là pour contribuer par vos commentaires, vos idées de reportages, l’évangélisation et les tests. Nous vous remercions donc de tout cœur. Nous vous verrons en ligne ! Nous avons ajouté de nombreuses fonctions comme le contrôle de la puissance des voies individuelles, des fonctions supplémentaires pour l’utilisateur, une commande de fonction beaucoup plus simple (F0-28), une meilleure gestion des tournois et plus encore. Nous continuons à tester toutes les combinaisons de moteurs et d’Arduino à des tensions différentes pour affiner nos relevés de courant. C’est important parce que nous voulons avoir une détection précise et rapide des courts-circuits, et parce que la raison pour laquelle la lecture des CV était parfois peu fiable dans le passé était due au fait de ne pas toujours détecter une impulsion de courant sur la piste. En plus d’une lecture plus précise du courant, nous avons dû complètement changer la façon dont nous recherchons un « ACK » (accusé de réception du train qui a reçu une commande). Nous vérifions donc maintenant immédiatement après l’envoi d’une commande au lieu d’attendre une douzaine de paquets ou plus. Cela signifie que nous ne manquons pas d’ACK pendant que cela se produit et que nous n’envoyons plus de paquets inutiles dès que nous en recevons un. Vous apprécierez la rapidité avec laquelle nous pouvons lire les CV maintenant ! Nous avons complètement réécrit le sens du courant et les routines de détection ACK pour mieux protéger vos trains et rendre la programmation plus précise. Nous avons créé une API interne pour la façon dont les modules communiquent entre eux. Le code est donc plus modulaire et chaque unité est dédiée à sa tâche spécifique. Nous avions besoin d’une plateforme qui nous permettrait de nous développer dans le futur. La première chose que nous avons trouvée est que pour permettre des changements faciles et pour pouvoir s’adapter à la technologie que nous pourrions vouloir utiliser à l’avenir, le code devait être plus modulaire. Chaque unité devait être une « boîte noire » qui, soit n’accomplissait qu’une seule tâche et la réalisait bien, soit prenait des données d’entrée et générait des données de sortie sans avoir à connaître le module avec lequel elle communiquait. C’est pourquoi nous avons créé une API intercalaire par laquelle les modules pouvaient communiquer. En débranchant simplement une unité et en en branchant une autre, nous pouvions continuer à travailler en utilisant des appareils différents. Un exemple de cela est l’entrée et la sortie. Peu importe que JMRI envoie des commandes à DCC++ EX ou qu’il s’agisse d’un contrôleur de cabine sans fil. Peu importe que le périphérique de sortie soit le moniteur série ou un écran I2C. Peu importe que vous souhaitiez utiliser un port série ou un périphérique réseau pour acheminer des données. Il est donc très facile de mettre en œuvre de nouvelles fonctionnalités avec de nouveaux appareils. Il suffit de créer une petite interface pour le nouveau dispositif que nous voulons mettre en œuvre. Cela présente l’avantage secondaire de permettre une meilleure lisibilité du code. Nous avons non seulement créé un découpage RailCom au sein du poste de commandement, mais nous développons un watt de lecture des données RailCom et d’établissement de rapports. Nous avons commencé avec le code de génération de signaux DCC, ce que nous appelons le « Waveform Generator ». Nous nous sommes réunis en équipe et avons cherché comment l’améliorer. Il est vite devenu évident qu’au lieu d’apporter des modifications au coup par coup, il fallait repenser tout le concept de la génération du signal et de l’utilisation des temporisateurs et des interruptions. Site web Quoi de neuf dans DCC++ EX ? Qu’est-ce qui est différent ? Bien que nous ayons apporté des modifications mineures à la version originale de DCC++ « BaseStation-Classic », tous les nouveaux développements vont de l’avant avec DCC++ EX. Au début, nous avons élargi les fonctionnalités, ajouté des fonctions et corrigé des bogues en travaillant à partir de la base de code existante. La première version de DCC++ sera familière à tous ceux d’entre vous qui ont joué avec le code. Cependant, nous tenons à souligner que la prochaine version, celle qui est actuellement en bêta-test, est une réécriture complète à partir de la base. Qui est derrière tout ça ? Et seront-ils un jour confrontés à la justice ? Qui sait, mais ce qui suit est une liste de ces noms associés à la reprise du projet BaseStation DCC++ et la réécriture / expansion en « DCC ++ EX ». Pourquoi avons-nous fait cela ? Vous pouvez nous trouver ici : `DCC++ EX Discord Server <https://discord.gg/y2sB4Fp>`_ `TrainBoard DCC++ Forum <https://www.trainboard.com/highball/index.php?forums/dcc.177/>`_ 