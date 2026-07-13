package com.omnicart.product.dto;

import lombok.*;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDto {
    private Long id;
    private String name;
    private String slug;
    private Long parentId;
    private List<CategoryDto> subcategories;
}
