NAME = ft_nginx

DIST        = ./dist/

SOURCE      = ./source/
CONFIG      = config/
CORE        = core/
HTTP        = http/
UTILS       = utils/
MODULES     = modules/

SRC = $(SOURCE)server.cpp \
      $(wildcard $(SOURCE)$(CONFIG)*.cpp) \
      $(wildcard $(SOURCE)$(CORE)*.cpp) \
      $(wildcard $(SOURCE)$(HTTP)*.cpp) \
      $(wildcard $(SOURCE)$(UTILS)*.cpp) \
      $(wildcard $(SOURCE)$(MODULES)*.cpp)

OBJ = $(patsubst $(SOURCE)%.cpp,$(DIST)%.o,$(SRC))

CC = c++

CFLAGS = -fsanitize=address -g3 # -Wall -Wextra -Werror # -std= will add it later

all: create_dist $(NAME)

create_dist:
	mkdir -p $(DIST)
	mkdir -p $(DIST)$(CONFIG)
	mkdir -p $(DIST)$(CORE)
	mkdir -p $(DIST)$(HTTP)
	mkdir -p $(DIST)$(UTILS)
	mkdir -p $(DIST)$(MODULES)

$(DIST)%.o: $(SOURCE)%.cpp
	$(CC) $(CFLAGS) -c $< -o $@

$(NAME): $(OBJ)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJ)

clean:
	rm -rf $(DIST)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re create_dist