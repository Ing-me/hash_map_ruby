class HashMap
    attr_accessor :EMPTY_VALUE, :DELETED_VALUE, :FILLED_VALUE, :table_size, :key, :Value, :Flag

    def initialize(t_size)
        self.EMPTY_VALUE = 0
        self.DELETED_VALUE = 1
        self.FILLED_VALUE = 2
        self.table_size = t_size
        self.key = Array.new(t_size + 1){0}
        self.Value = Array.new(t_size + 1){0}
        self.Flag = Array.new(t_size + 1){self.EMPTY_VALUE}
    end

    def compute_hash(key)
        # key % self.table_size
        key = key.to_s
        hash_code = 0
        prime_number = 31
        key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
        hash_code = hash_code % self.table_size 
        hash_code
    end

    def resolveFun(index)
        return index
    end

    def add(key, value)
       p hash_value = self.compute_hash(key)
        
        i = 0
        while(i < self.table_size)
            if(self.Flag[hash_value] == self.EMPTY_VALUE || self.Flag[hash_value] == self.DELETED_VALUE)
                self.key[hash_value] = key
                self.Value[hash_value] = value
                self.Flag[hash_value] = self.FILLED_VALUE
                return true
            end
           p hash_value += resolveFun(i)
           p hash_value %= self.table_size
            i += 1
            puts "-------"
        end
        return false
    end

    def add2(value)
        return self.add(value, value)
    end

    def printHash() 
        print("Hash table contains ::")
        i = 0
        p self.Flag
        p self.key
        p self.Value
        while(i < self.table_size)
            if(self.Flag[i] == self.FILLED_VALUE)
                print("(" + self.key[i].to_s + "=>" + self.Value[i].to_s + ")")
            end
            i += 1
        end
        print("\n")
    end

    def get(key)
        hash_value = self.compute_hash(key)
        i = 0
        while(i < self.table_size)
            if(self.Flag[hash_value] == self.EMPTY_VALUE)
                return nil
            end
            if(self.Flag[hash_value] == self.FILLED_VALUE && self.key[hash_value] == key)
                return self.Value[hash_value]
            end
            hash_value += self.resolveFun(i)
            hash_value %= self.table_size
            i += 1
        end
        return nil
    end

    def has(key)
        hash_value = self.compute_hash(key)

        i = 0
        while(i < self.table_size)
            if(self.Flag[hash_value] == self.EMPTY_VALUE)
                return false
            end
            if(self.Flag[hash_value] == self.FILLED_VALUE && self.key[hash_value] == key)
                return true
            end
            hash_value += self.resolveFun(i)
            hash_value %= self.table_size
            i += 1
        end
        return false
    end

    def remove(key)
        hash_value = self.compute_hash(key)

        i = 0

        while(i < self.table_size)
            if(self.Flag[hash_value] == self.EMPTY_VALUE)
                return false
            end
            if(self.Flag[hash_value] == self.FILLED_VALUE && self.key[hash_value] == key)
                self.Flag[hash_value] = self.DELETED_VALUE
                return true
            end
            hash_value += self.resolveFun(1)
            hash_value %= self.table_size
            i += 1
        end
        return false
    end

    def length
        count = 0
        i = 0
        while(i < self.table_size)
            if(self.Flag[i] == self.FILLED_VALUE)
                count += 1
            end
            i +=1
        end
        count
    end

    def clear 
        i = 0
        while(i < self.table_size)
            if(self.Flag[i] == self.FILLED_VALUE)
                self.Flag[i] = self.DELETED_VALUE
                return true
            end
            i += 1
        end
        return nil
    end

    def keys_array
        i = 0 
        key_array = []
        while(i < self.table_size)
            if(self.Flag[i] == self.FILLED_VALUE)
                key_array << self.key[i]
            end
            i += 1
        end
        key_array
    end

    def values_array
        i = 0 
        value_array = []
        while(i < self.table_size)
            if(self.Flag[i] == self.FILLED_VALUE)
                value_array << self.Value[i]
            end
            i += 1
        end
        value_array
    end

    def key_value_array
        i = 0
        all_entries = []
        
        i = 0
        while(i < self.table_size)
            entry = []
            if(self.Flag[i] == self.FILLED_VALUE)
                entry += [self.key[i], self.Value[i]]
            end
            if(!entry.empty?)
                all_entries << entry
            end
            i += 1
        end        
        all_entries
    end

end


class Hashset

end

hash = HashMap.new(20)

# hash.add(1, 100)
# hash.add(2, 150)
# hash.add(2, 150)
 hash.add(1, "pepe")
 hash.add(2, "popa")
 hash.add("Carla", "pepa")
hash.printHash

p hash.keys_array
p hash.values_array
p hash.key_value_array

# p hash.get("Carla")
# p hash.has(1)
# # p hash.remove(1)
# hash.clear
# hash.printHash


