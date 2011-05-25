import MySQLdb, sys, redis, collections
#connection a la base sqlite3
FRIENDS_WEIGHT=1

conn=MySQLdb.connect(host=sys.argv[1], user='mk',passwd='magic_kitchen',db='magic_kitchen')
cur=conn.cursor()
#connection a la base redis

r=redis.Redis(sys.argv[2])
#selection des stats utilisateurs
cur.execute('SELECT ingredient_id, weight FROM users_ingredients WHERE user_id=%s AND weight!=0',sys.argv[3])
user_stats=collections.Counter(dict(cur.fetchall()))

#recuperation des following utilisateurs
friends=r.smembers('User:'+sys.argv[3]+':following')
#recuperation des stats following
following_stats=collections.Counter()
for f in friends:
  cur.execute('SELECT ingredient_id, weight FROM users_ingredients WHERE user_id=%s AND weight!=0',(f,))
  following_stats=following_stats+collections.Counter(dict(cur.fetchall()))
#print following_stats   
for ing in following_stats:
  following_stats[ing]=following_stats[ing]*FRIENDS_WEIGHT/len(friends)
#Calcul du nombre d'ingredients total pour moyenner
num=sum(user_stats.values())+sum(following_stats.values())
#calcul des coefficients
coeffs=user_stats+following_stats
weight=0
for i in coeffs:
  #ecriture des coefficients
  cur.execute('INSERT INTO users_ingredients (user_id,ingredient_id,weight,coeff) VALUES (%s,%s,%s,%s) ON DUPLICATE KEY UPDATE coeff=%s',(sys.argv[3],i,weight,coeffs[i]/num,coeffs[i]/num))
conn.commit()
conn.close()