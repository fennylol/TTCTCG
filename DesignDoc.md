# Take The Cake Trading Card Game: A gatcha-autobattler.
Players will open LOOTBOXES to get critters, weapon parts, tools, or cake ingredients. 
These can then be used to play the asymetric CTF auto-battler where the attacking team
attempts to take as much cake form the defenders as possible. 



## Cards
Pulled from the gatcha. Open a pack, get some cards. All cards have a common version, 
and some have one or more rare versions.

### code MVP
SCENES:
- lootbox
- collection
- deck mngr

CLASSES:
- card
- deck



## Auto Battler
GAME LOOP:
3/4 down isometric(?) autobattler. there is a cake in the middle of a due-process-esque
building. attackers attempt to get their critters to the cake while defenders try to
stop them. once a critter reaches the cake, it will drop everything and begin eating. 
defenders can stop an attacker to get it off the cake, should they reach it. the round
is over once all the cake is eaten, all attacking critters die, or the timer runs out.

attackers will be placed on the outskirts and make their way towards the cake in a 
simulated fashion, according to rules. defenders will move around (or otherwise defend) 
the play area according to their own rules. 

CRITTERS:
have stats (speed, health, sight range, sight FOV, maybe accuracy, etc)
and behaviors (which determine how a critter moves and attacks)

WEAPONS:
have damage, range, spread, unweidlyness, and other special properties

ITEMS:
IDK yet. but feels like defenders and attackers should get consumables. maybe you can 
instruct a critter to use an item in a room? or theyre used in certain situations? or
maybe all creatures have a behavioir class (attacker, supporter, tank, artilary, etc)
which determines when an item would be used. could be made of modules that alter the
way a weapon fires.

INGREDIENTS:
modifies aspects of the cake. maybe you can choose to have it have less health but it 
deals damage when at 50% health? should be limited by "volume" of the bowl. NOT AN
IMPORTANT FEATURE.