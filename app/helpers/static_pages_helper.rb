module StaticPagesHelper
    def counter(record)
        record.counter = record.counter + 1
        record.save
    end
end
