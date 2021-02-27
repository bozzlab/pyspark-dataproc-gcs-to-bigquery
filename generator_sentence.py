from faker import Faker

faker = Faker()

with open("text_sample.txt", "w") as text_file:
    for _ in range(10000000):
        text_file.write(faker.paragraph(nb_sentences=5) + "\n")
