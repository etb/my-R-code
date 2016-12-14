# thief escape conditional expectation
thieves <- 200
time <- 0
for (i in 1:thieves) {
	escape = 0
	while (escape == 0) {
		door = ceiling(runif(1, 0,3))
		if (door == 1) {
			escape = 1
			time = time + 6
		}
		if (door == 2) time = time + 3
		if (door == 3) time = time + 9
	}
}
# print(time/thieves)
cat(thieves, "thieve(s) escaped (on avg.) in", (time/thieves))
