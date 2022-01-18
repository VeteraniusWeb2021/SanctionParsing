class Interval():
    def __init__(self, general_id, date, description, end_date, modified_at, publisher, publisher_url, record_id, retrieved_at,
                 source_url, start_date, summary):
        self.general_id = general_id #ідентифікатор для однозначного визначення сутності (буде присутній у всіх класах)
        self.date = date
        self.description = description
        self.end_date = end_date
        self.modified_at = modified_at
        self.publisher = publisher
        self.publisher_url = publisher_url
        self.record_id = record_id
        self.retrieved_at = retrieved_at
        self.source_url = source_url
        self.start_date = start_date
        self.summary = summary