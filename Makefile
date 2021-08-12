# define the name of the virtual environment directory
VENV := venv

# default target, when make executed without arguments
all: run


$(VENV)/bin/activate: requirements.txt
	if !([ -d "venv" ]); then \
	    python3 -m venv $(VENV); \
		echo "Установка необходимых компонентов"; \
	    ./$(VENV)/bin/pip3 install -r requirements.txt; \
	fi


# venv is a shortcut target
venv: $(VENV)/bin/activate
	. $(VENV)/bin/activate


make_mode: venv
	$(VENV)/bin/python3 model.py

run: venv make_mode
	$(VENV)/bin/streamlit run main.py


clean:
	rm -rf $(VENV)
	find . -type f -name '*.pyc' -delete


.PHONY: all venv run clean make_mode