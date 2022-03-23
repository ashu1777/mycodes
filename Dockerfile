FROM python3
RUN pip install numpy scipy pandas
CMD ["python", ./main.py]
