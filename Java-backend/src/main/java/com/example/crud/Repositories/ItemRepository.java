package com.example.crud.Repositories;

import com.example.crud.Mode.Item;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ItemRepository extends JpaRepository<Item, Long> {
}