import numpy as np
import csv

ratings_dat = [i.strip().split('::') for i in open("ratings.dat").readlines()]
movies_dat = [i.strip().split('::') for i in open("movies.dat").readlines()]

print('Loaded .dat files.')

USERNUM = 6040
MOVIENUM = 3952
TOPMOVIENUM = 20

movies = {}
for movie in movies_dat:
	movies[int(movie[0])] = f"{movie[1]} ({movie[2]})"

print('Movies dictionary created.')

mat = np.zeros((USERNUM + 1, MOVIENUM + 1))
for rating in ratings_dat:
	user = int(rating[0])
	movie = int(rating[1])
	rank = int(rating[2])
	mat[user][movie] = rank

print('Matrix created.')

movie_ratings = []  # list of [num of ratings, averate rating, movie number]
for movie in range(1, MOVIENUM + 1):
	r = [0, 0, movie]
	for user in range(1, USERNUM + 1):
		if mat[user][movie] != 0:
			r[0] += 1
			r[1] += mat[user][movie]
	if r[0] != 0:
		r[1] /= r[0]
	movie_ratings += [r]
movie_ratings.sort(reverse=True)
top_movies = []
for r in movie_ratings:
	if r[2] in movies:
		top_movies += [r[2]]
	if len(top_movies) == TOPMOVIENUM:
		break

print('Top movies (from available movies) found.')

selected_users = [] # list of users who have seen all of the top movies
for user in range(USERNUM):
	seenTopMovies = True
	for movie in top_movies:
		if mat[user][movie] == 0:
			seenTopMovies = False
			break
	if seenTopMovies:
		selected_users += [user]

print('Selected users for evaluation.')

# Load test user
test_user = {}
with open('trial_user.csv', 'r') as file:
	reader = csv.reader(file)
	first = True
	for row in reader:
		if first:
			first = False
			continue
		r = list(row)
		movie = int(r[0])
		rating = int(r[1])
		if movie in top_movies:
			test_user[movie] = rating
test_user = np.array([test_user[movie] for movie in top_movies])
print('Loaded test user.')

def euclid2(x, y):
	d = 0
	for i in range(TOPMOVIENUM):
		d += (x[i] - y[i])**2
	return d

def pearson(x, y):
	mux = x.mean()
	muy = y.mean()
	sx = 0
	sy = 0
	cxy = 0
	for i in range(TOPMOVIENUM):
		xi = x[i] - mux
		yi = y[i] - mux
		cxy += xi*yi
		sx += xi**2
		sy += yi**2
	return cxy / np.sqrt(sx) / np.sqrt(sy)

def fittest_euclid(this_user):
	fittest_user = -1
	fittest_value = np.Inf
	for user in range(1, USERNUM):
		uservector = mat[user][top_movies]
		euc = euclid2(this_user, uservector)
		if euc < fittest_value:
			fittest_user = user
			fittest_value = euc
	return fittest_user

def fittest_pearson(this_user):
	fittest_user = -1
	fittest_value = 0
	for user in range(1, USERNUM):
		uservector = mat[user][top_movies]
		pea = pearson(this_user, uservector)
		if pea > fittest_value:
			fittest_user = user
			fittest_value = pea
	return fittest_user

def suggest(user):
	rating = mat[user][:].tolist()
	listofmovies = [[rating[movie], movie] for movie in range(1, MOVIENUM)]
	listofmovies.sort(reverse=True)
	return [movie[1] for movie in listofmovies[:20]]

def interact(this_user):
	test_fittest_euclid_user = fittest_euclid(this_user)
	print("Chose fittest user (Euclidean distance).")
	test_fittest_pearson_user = fittest_pearson(this_user)
	print("Chose fittest user (Pearson's r).")
	print(f"\nSuggested user (Euclidean distance): {test_fittest_euclid_user}")
	print(f"Suggested movies (Euclidean distance):")
	l = suggest(test_fittest_euclid_user)
	for movie in l:
		print(f"\t{movies[movie]}")
	print('\n')
	print(f"Suggested user (Pearson's r): {test_fittest_pearson_user}")
	print(f"Suggested movies (Pearson's r):")
	l = suggest(test_fittest_pearson_user)
	for movie in l:
		print(f"\t{movies[movie]}")
	print('\n')

interact(test_user)

print(f"Now it's your turn! How would you rate the following {TOPMOVIENUM} movies?")
MyMovies = np.zeros((TOPMOVIENUM + 1,))
for i in range(TOPMOVIENUM):
	movie = top_movies[i]
	print(f"{movies[movie]}: ", end='')
	MyMovies[i] = int(input())
interact(MyMovies)